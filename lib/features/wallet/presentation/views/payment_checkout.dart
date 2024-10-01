import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterwavePayNow extends StatefulWidget {
  final String secretKey;
  final String reference;
  final String callbackUrl;
  final String currency;
  final String email;
  final double amount;
  final metadata;
  final paymentChannel;
  final void Function() transactionCompleted;
  final void Function() transactionNotCompleted;

  const FlutterwavePayNow({
    Key? key,
    required this.secretKey,
    required this.email,
    required this.reference,
    required this.currency,
    required this.amount,
    required this.callbackUrl,
    required this.transactionCompleted,
    required this.transactionNotCompleted,
    this.metadata,
    this.paymentChannel,
  }) : super(key: key);

  @override
  State<FlutterwavePayNow> createState() => _FlutterwavePayNowState();
}

class _FlutterwavePayNowState extends State<FlutterwavePayNow> {
  /// Makes HTTP Request to Flutterwave for access to make payment.
  Future<String> _makePaymentRequest() async {
    http.Response? response;
    final amount = widget.amount * 100;

    try {
      // Sending Data to Flutterwave.
      response = await http.post(
        Uri.parse('https://api.flutterwave.com/v3/payments'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.secretKey}',
        },
        body: jsonEncode({
          "tx_ref": widget.reference,
          "amount": widget.amount.toString(),
          "currency": widget.currency,
          "redirect_url": widget.callbackUrl,
          "payment_options": widget.paymentChannel,
          "customer": {
            "email": widget.email,
          },
          "customizations": {
            "title": "Payment Title",
            "description": "Payment for XYZ",
            "logo": "https://yourlogo.com/logo.png"
          }
        }),
      );
    } on Exception catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        var snackBar =
            SnackBar(content: Text("Error occurred: ${e.toString()}"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    if (response!.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData['data']['link']; // Hosted link
    } else {
      throw Exception(
          "Response Code: ${response.statusCode}, Response Body: ${response.body}");
    }
  }

  /// Checks for transaction status of current transaction before view closes.
  Future _checkTransactionStatus(String ref) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse('https://api.flutterwave.com/v3/transactions/$ref/verify'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.secretKey}',
        },
      );
    } on Exception catch (_) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        var snackBar = const SnackBar(
            content: Text("Please check your internet connection"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    if (response!.statusCode == 200) {
      var decodedRespBody = jsonDecode(response.body);
      if (decodedRespBody["data"]["status"] == "successful") {
        widget.transactionCompleted();
      } else {
        widget.transactionNotCompleted();
      }
    } else {
      widget.transactionNotCompleted();
      throw Exception(
          "Response Code: ${response.statusCode}, Response Body: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
          onPressed: () {
            Navigator.pop(context);
            widget.transactionNotCompleted();
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: _makePaymentRequest(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              final controller = WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setUserAgent("Flutter;Webview")
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onNavigationRequest: (request) async {
                      print(request.url);
                      if (request.url.contains(widget.callbackUrl)) {
                        // await _checkTransactionStatus(widget.reference)
                        //     .then((value) {
                        Navigator.pop(context);

                        widget.transactionCompleted();

                        // });
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                )
                ..loadRequest(Uri.parse(
                    snapshot.data!)); // Load the hosted link from the response
              return WebViewWidget(
                controller: controller,
              );
            }

            if (snapshot.hasError) {
              return Material(
                child: Center(
                  child: Text('${snapshot.error}'),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
