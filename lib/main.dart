// main.dart

import 'package:expense_tracker/screens/splash_screen.dart'; // <-- IMPORTANT: Import your new splash screen
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Ensure Flutter and Firebase are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform, // If you use FlutterFire CLI
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      // The home is now always the SplashScreen.
      // The SplashScreen itself will handle navigating to the next page.
      home: SplashScreen(),
    );
  }
}