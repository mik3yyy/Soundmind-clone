import 'package:flutter/material.dart';
import '../blocs/wallet_bloc.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet Page'),
      ),
      body: Center(
        child: Text('Welcome to the Wallet feature!'),
      ),
    );
  }
}
