import 'package:flutter/material.dart';

Widget greetingsLoginWidget(BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        // Greeting
        Text(
          'Hello, nice to meet you',
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),
        // Title
        Text(
          'Login To HuluTaxi!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 12),
        // Desc
        Text(
          'Please enter the phone number that you registered with.',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    ),
  );
}