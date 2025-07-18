// auth_gate.dart

import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/register_screen.dart'; // <-- CHANGED
import 'package:expense_tracker/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Use the stream from your AuthService for consistency
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User is logged in, show Home
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // User is not logged in, show Register Screen as the entry point
        return const RegisterScreen(); // <-- FIXED: Start with RegisterScreen
      },
    );
  }
}