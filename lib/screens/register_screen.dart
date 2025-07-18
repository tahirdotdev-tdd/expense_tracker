// screens/register_screen.dart

import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/services/auth_service.dart';
import 'package:expense_tracker/styles/colors/colors.dart';
import 'package:expense_tracker/widgets/google_signin_button.dart';
import 'package:expense_tracker/widgets/sign_up_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 1. ADD A STATE VARIABLE FOR LOADING
  bool _isLoading = false;
  bool _obscureText = true;

  void handleSignUp() async {
    // Prevent function from running again if it's already loading
    if (_isLoading) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email and Password cannot be empty."),
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
      await _authService.signUp(email, password);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registered successfully! Please log in."),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email.';
      } else {
        message = e.message ?? "An error occurred during sign up.";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ConstrainedBox(
        constraints:
        BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your header container remains the same...
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
                              top: 50, left: 15, right: 20),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: Colors.white, size: 32),
                                onPressed: () => Navigator.pop(context),
                              ),
                              const Spacer(),
                              Image.asset('assets/images/app_logo.png',
                                  width: 64),
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
                                    'Register Now!', // Updated text
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
                                    "Create a Fresh Account", // Updated text
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
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.05,
                      child: Image.asset(
                        'assets/images/world_map.png',
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
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
                          horizontal: 24, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Email", isRequired: true),
                            const SizedBox(height: 8),
                            _buildInput(_emailController,
                                hint: "olivia@untitledui.com"),
                            const SizedBox(height: 20),
                            _buildLabel("Password", isRequired: true),
                            const SizedBox(height: 8),
                            _buildInput(
                              _passwordController,
                              hint: "••••••••",
                              isPassword: true,
                            ),
                            const SizedBox(height: 30),

                            // 4. PASS THE LOADING STATE TO THE BUTTON
                            SignUpButton(
                              onTap: handleSignUp,
                              isLoading: _isLoading,
                            ),
                            const SizedBox(height: 10),
                            // The rest of your UI remains the same...
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account? ",
                                    style: TextStyle(
                                        color: Color(0xff59606E),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                                GestureDetector(
                                  onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginScreen()),
                                  ),
                                  child: Text("Login",
                                      style: TextStyle(
                                          color: splashScreenColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Center(
                              child: Text("OR",
                                  style: TextStyle(
                                      color: Color(0xffB1AEAE),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
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

  Widget _buildLabel(String label, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        children: isRequired
            ? [
          TextSpan(
            text: ' *',
            style: TextStyle(
              color: splashScreenColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]
            : [],
      ),
    );
  }

  Widget _buildInput(TextEditingController controller,
      {String hint = '', bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _obscureText : false,
      cursorColor: splashScreenColor,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () => setState(() {
            _obscureText = !_obscureText;
          }),
        )
            : null,
        hintStyle: const TextStyle(color: Color(0xff667085)),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffD0D5DD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: splashScreenColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffD0D5DD)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}