import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> signInWithGoogle() async {
    try {
      final UserCredential authResult = await _auth.signInWithPopup(GoogleAuthProvider());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
