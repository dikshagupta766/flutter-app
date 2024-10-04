import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'forgetpassword.dart';
import 'signup.dart';
import 'splash.dart'; // Import the Splash Page

void main() {
  runApp(FlipkartApp());
}

class FlipkartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flipkart Clone',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // Set the initial route to the splash screen
      routes: {
        '/': (context) => SplashPage(), // Splash screen as the first route
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
