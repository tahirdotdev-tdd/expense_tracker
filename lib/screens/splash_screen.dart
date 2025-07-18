// screens/splash_screen.dart

import 'dart:async';
import 'package:expense_tracker/services/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';
import '../styles/colors/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    // We now call a dedicated function to handle the complex navigation logic.
    _determineNextScreen();
  }

  // --- NEW, UPDATED LOGIC IS HERE ---
  Future<void> _determineNextScreen() async {
    // 1. Check SharedPreferences to see if the user has completed onboarding before.
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding = prefs.getBool('onboarding_complete') ?? false;

    // 2. Define the destination widget based on the check.
    final Widget destination = hasSeenOnboarding
        ? const AuthGate() // If yes, go to the AuthGate.
        : const MultiStepOnboardingScreen(); // If no, go to Onboarding.

    // 3. Use your original timer to ensure the splash screen is visible.
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // 4. Navigate using your beautiful PageRouteBuilder, but with the correct destination.
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            // THE KEY CHANGE: We use the 'destination' variable here.
            pageBuilder: (context, animation, secondaryAnimation) => destination,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: Curves.easeInOut));
              final offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // --- YOUR UI CODE IS UNCHANGED ---
  // No changes were needed here, all your beautiful UI is preserved.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bcg_img.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.5),
            ),
          ),
          Positioned.fill(
            child: Container(color: splashScreenColor.withOpacity(0.9)),
          ),
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 138,
              ),
            ),
          ),
        ],
      ),
    );
  }
}