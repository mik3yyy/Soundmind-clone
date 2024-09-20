import 'package:flutter/material.dart';
import '../blocs/setting_bloc.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Page'),
      ),
      body: Center(
        child: Text('Welcome to the Setting feature!'),
      ),
    );
  }
}
