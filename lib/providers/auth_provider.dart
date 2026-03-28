import 'package:firebase_auth/firebase_auth.dart';
import 'package:evently_app/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isPasswordObscured = true;
  bool get isPasswordObscured => _isPasswordObscured;

  bool _isConfirmPasswordObscured = true;
  bool get isConfirmPasswordObscured => _isConfirmPasswordObscured;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
    notifyListeners();
  }

  Future<String?> signUp({
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;

    _isLoading = true;
    notifyListeners();

    try {
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await credential.user?.updateDisplayName(name);
      
      _isLoading = false;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      if (e.code == 'weak-password') {
        return StringsManager.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        return StringsManager.emailInUse;
      }
      return e.message;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return StringsManager.somethingWentWrong;
    }
  }

  Future<String?> logIn({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    String email = emailController.text.trim();
    String password = passwordController.text;

    _isLoading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      _isLoading = false;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();

      // We use a generic message for both 'user-not-found' and 'wrong-password'
      // This is the industry standard for security (like Facebook/Instagram)
      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return StringsManager.invalidCredentials;
      }
      return e.message;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return StringsManager.somethingWentWrong;
    }
  }
}
