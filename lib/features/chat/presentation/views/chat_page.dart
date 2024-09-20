import 'package:flutter/material.dart';
import '../blocs/chat_bloc.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: Center(
        child: Text('Welcome to the Chat feature!'),
      ),
    );
  }
}
