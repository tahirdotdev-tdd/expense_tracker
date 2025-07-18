// login_screen.dart

import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/register_screen.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:expense_tracker/styles/colors/colors.dart';
import 'package:expense_tracker/widgets/google_signin_button.dart';
import 'package:expense_tracker/widgets/log_sign_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 1. ADD A STATE VARIABLE FOR LOADING
  bool _isLoading = false;

  void handleLogin() async {
    // Prevent function from running again if it's already loading
    if (_isLoading) return;

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email and password cannot be empty."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 2. SET LOADING TO TRUE to show the indicator
    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.login(email, password);

      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        message = 'Invalid email or password. Please try again.';
      } else {
        message = e.message ?? "An error occurred during login.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } finally {
      // 3. IMPORTANT: ALWAYS SET LOADING TO FALSE at the end
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _obscureText = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Top Blue Container
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(color: splashScreenColor),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 50,
                            left: 15,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              const Spacer(),
                              Image.asset(
                                'assets/images/app_logo.png',
                                width: 64,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome Back 👋', // Updated text
                                    style: GoogleFonts.inter(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(height: 5),
                                  Text(
                                    "Let's Get You Logged In", // Updated text
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Image.asset(
                        'assets/images/world_map.png',
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              // <-!-------------------------------------------------------------------------------------------------------------!->
              // 🔽 Full Form Area with Overlay Background Image
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.05,
                        child: Image.asset(
                          'assets/images/bcg_img.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Email',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: splashScreenColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "olivia@untitledui.com",
                                hintStyle: const TextStyle(
                                  color: Color(0xff667085),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xffD0D5DD),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: splashScreenColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xffD0D5DD),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              cursorColor: splashScreenColor,
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              text: TextSpan(
                                text: 'Password',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: splashScreenColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              cursorColor: splashScreenColor,
                              decoration: InputDecoration(
                                hintText: "••••••••",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                  color: Color(0xff667085),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xffD0D5DD),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: splashScreenColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xffD0D5DD),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor:
                                Colors.grey, // Color when unchecked
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(
                                      6,
                                    ), // Semi-rounded
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        side: const BorderSide(color: Colors.grey),
                                        value: isChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                        activeColor:
                                        splashScreenColor, // ✅ Your primary color
                                      ),
                                      const Text(
                                        "Remember me",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Forgot Password?",
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: splashScreenColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            // 4. PASS THE LOADING STATE TO THE BUTTON
                            LogSignButton(
                              onTap: handleLogin,
                              isLoading: _isLoading,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Color(0xff59606E),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const RegisterScreen(),
                                    ),
                                  ),
                                  child: Text(
                                    "Register Now",
                                    style: TextStyle(
                                      color: splashScreenColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Center(
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: Color(0xffB1AEAE),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const GoogleSigninButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}