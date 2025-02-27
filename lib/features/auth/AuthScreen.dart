import 'package:flutter/material.dart';
import '../../features/bottom_nav_bar/BottomNavBar.dart';
import 'AuthService.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final userCredential = await _authService.loginWithGoogle();
            if (userCredential != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBar()),
              );
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}