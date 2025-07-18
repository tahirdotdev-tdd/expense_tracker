// widgets/log_sign_button.dart

import 'package:expense_tracker/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogSignButton extends StatelessWidget {
  final VoidCallback onTap;
  // A new parameter to control the loading state
  final bool isLoading;

  const LogSignButton({
    super.key,
    required this.onTap,
    this.isLoading = false, // Default to not loading
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Disable tapping while the button is in a loading state
      onTap: isLoading ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        // Using double.infinity is better for responsiveness than a fixed width
        width: double.infinity,
        decoration: BoxDecoration(
          // Make the button slightly transparent when loading
          color: isLoading ? splashScreenColor.withOpacity(0.7) : splashScreenColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: isLoading
        // If loading is true, show a progress indicator
            ? const SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        )
        // Otherwise, show the original text
            : Text(
          "Login   →",
          style: GoogleFonts.inter(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}