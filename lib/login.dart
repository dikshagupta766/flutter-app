import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the stored email and password
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    // Check if the entered credentials match the stored ones
    if (emailController.text == storedEmail &&
        passwordController.text == storedPassword) {
      await prefs.setBool('isLoggedIn', true); // Set logged-in status

      // Navigate to HomePage
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show error message if credentials don't match
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome Back!')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: Text('Don’t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
