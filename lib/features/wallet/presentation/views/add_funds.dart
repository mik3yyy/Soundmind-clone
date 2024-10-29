import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterwave_standard_smart/core/flutterwave.dart';
import 'package:flutterwave_standard_smart/models/requests/customer.dart';
import 'package:flutterwave_standard_smart/models/requests/customizations.dart';
import 'package:flutterwave_standard_smart/models/responses/charge_response.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/extensions/widget_extensions.dart';
import 'package:sound_mind/core/widgets/custom_button.dart';
import 'package:sound_mind/core/widgets/custom_text_field.dart';
import 'package:sound_mind/features/Authentication/presentation/blocs/Authentication_bloc.dart';
import 'package:sound_mind/features/wallet/presentation/blocs/top_up/topup_wallet_cubit.dart';

class AddFundsPage extends StatefulWidget {
  const AddFundsPage({super.key});

  @override
  State<AddFundsPage> createState() => _AddFundsPageState();
}

class _AddFundsPageState extends State<AddFundsPage> {
  TextEditingController textEditingController = TextEditingController();

  handlePaymentInitialization(
      {required String amout, required String ref}) async {
    print(dotenv.env['NEXT_PUBLIC_FLUTTERWAVE_PUBLIC_KEY']!);

    var user = (context.read<AuthenticationBloc>().state as UserAccount).user;

    final Customer customer = Customer(
        name: user.lastName + user.firstName,
        phoneNumber: user.phoneNumber,
        email: user.email);
    final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: dotenv.env['NEXT_PUBLIC_FLUTTERWAVE_PUBLIC_KEY']!,
      currency: "NGN",
      redirectUrl: "https://michaelokpechi.netlify.app",
      txRef: ref,
      amount: amout,
      customer: customer,
      paymentOptions: "ussd, card, barter, payattitude",
      customization: Customization(title: "My Payment"),
      isTestMode: true,
    );
    final ChargeResponse response = await flutterwave.charge();

    if (response.status != null) {
      if (response.status == 'completed') {
        context
            .read<TopUpCubit>()
            .confirmTopUp(response.txRef!, response.transactionId!);
        context.pop();
      }
    }
    // if(response.success){}
  }

  // handlePaymentInitialization(
  //     {required String amout, required String ref}) async {
  //   var user = (context.read<AuthenticationBloc>().state as UserAccount).user;
  //   print(dotenv.env['NEXT_PUBLIC_FLUTTERWAVE_PUBLIC_KEY']!);
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => FlutterwavePayNow(
  //           secretKey: dotenv.env[
  //               'NEXT_PUBLIC_FLUTTERWAVE_PUBLIC_KEY']!, //"FLWPUBK_TEST-Ob72b3f953798dd6d3af92f0f1ac6bfc-X",
  //           email: user.email,
  //           reference: ref,
  //           currency: "NGN",
  //           amount: double.parse(amout),
  //           callbackUrl:
  //               "https://www.linkedin.com/in/chibuikem-michael-okpechi/",
  //           transactionCompleted: () {},
  //           transactionNotCompleted: () {},
  //         ),
  //       ));
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TopUpCubit, TopUpState>(
      listener: (context, state) {
        if (state is TopUpInitiated) {
          print(state.topUpDetails);
          handlePaymentInitialization(
            amout: textEditingController.text,
            ref: state.topUpDetails['data'],
          );
        }
        if (state is TopUpError) {
          context.showSnackBar(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: context.colors.black,
          ),
          centerTitle: false,
          title: const Text("Add Funds"),
        ),
        body: Column(
          children: [
            CustomTextField(controller: textEditingController, hintText: ""),
            Gap(20),
            BlocBuilder<TopUpCubit, TopUpState>(
              builder: (context, state) {
                return CustomButton(
                    label: "Top Up",
                    notifier: ValueNotifier(state is TopUpLoading),
                    onPressed: () {
                      context.read<TopUpCubit>().initiateTopUp(
                          double.parse(textEditingController.text));
                    });
              },
            )
          ],
        ).withSafeArea().withCustomPadding(),
      ),
    );
  }
}

class AddFundsPage2 extends StatefulWidget {
  const AddFundsPage2({super.key});

  @override
  State<AddFundsPage2> createState() => _AddFundsPage2State();
}

class _AddFundsPage2State extends State<AddFundsPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: context.colors.black,
        ),
        centerTitle: false,
        title: Text("Add Funds"),
      ),
      body: SizedBox(
        height: context.screenHeight * .5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Gap(10),
            CircleAvatar(
                radius: 30,
                backgroundColor: context.secondaryColor,
                child: Icon(
                  Icons.house,
                  color: context.primaryColor,
                  size: 30,
                )),
            Text(
              "Wallet Account Number",
              style: context.textTheme.displayMedium,
            ),
            const Text(
              "Make a transfer to this account number and your wallet will be funded.",
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: context.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: context.screenWidth * .9,
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bank Name"),
                  Text(
                    "GT Bank",
                    style: context.textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: context.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: context.screenWidth * .9,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Account number"),
                      Text(
                        "07728468590",
                        style: context.textTheme.displaySmall,
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.copy,
                        color: context.primaryColor,
                      ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: context.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              width: context.screenWidth * .9,
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Account name"),
                  Text(
                    "SoundMind inc",
                    style: context.textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ],
        ).withSafeArea().withCustomPadding(),
      ),
    );
  }
}
