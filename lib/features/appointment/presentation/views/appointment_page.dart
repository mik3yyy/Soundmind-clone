import 'package:flutter/material.dart';
import '../blocs/appointment_bloc.dart';

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Page'),
      ),
      body: Center(
        child: Text('Welcome to the Appointment feature!'),
      ),
    );
  }
}
