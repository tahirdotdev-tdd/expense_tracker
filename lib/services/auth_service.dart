// auth_service.dart (Simplified Version - No Firestore)

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up now only needs email and password
  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      // Re-throw the exception to be caught by the UI
      rethrow;
    }
  }

  // Login remains the same
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      // Re-throw the exception to be caught by the UI
      rethrow;
    }
  }

  // Logout remains the same
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Auth State Stream remains the same
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}