import 'package:expense_tracker/styles/colors/colors.dart';
import 'package:flutter/material.dart';

class OnboardingButtons extends StatelessWidget {
  final VoidCallback onSkip;
  final VoidCallback onNext;
  const OnboardingButtons({super.key, required this.onSkip, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onSkip,
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: 154,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: splashScreenColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Skip",
                style: TextStyle(
                  color: splashScreenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8,),
          GestureDetector(
            onTap: onNext,
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: 154,
              decoration: BoxDecoration(
                color: splashScreenColor,
                border: Border.all(width: 1, color: splashScreenColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Next  →",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
