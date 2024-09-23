import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'forgetpassword.dart';
import 'signup.dart';

void main() {
  runApp(SnapchatApp());
}

class SnapchatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snapchat Clone',
      theme: ThemeData(primarySwatch: Colors.yellow),
      initialRoute: '/login', // Set the initial route
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
