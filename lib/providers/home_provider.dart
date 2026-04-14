import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../core/models/user_model.dart';
import '../core/remote/network/firestore_service.dart';
import '../core/remote/network/supabase_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;
  String currentCategoryId = "all";

  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: null,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        final existingUser = await FirestoreService().getUserData(user.uid);
        if (existingUser == null) {
          await FirestoreService().saveUserData(
            uid: user.uid,
            userName: user.displayName ?? "User",
            email: user.email ?? "",
            profilePic: user.photoURL ?? "",
          );
        }
        await fetchUserData(user.uid);
      }
    } catch (e) {
      debugPrint("❌ Error during Google Sign-In: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void changeCategoryView(String id) {
    currentCategoryId = id;
    notifyListeners();
  }

  Future<void> fetchUserData(String uid) async {
    if (_currentUser != null) return;

    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await FirestoreService().getUserData(uid);
    } catch (e) {
      debugPrint("Error fetching user data in HomeProvider: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateProfilePicLocally(String imageUrl) {
    if (_currentUser != null) {
      _currentUser = UserModel(
        uid: _currentUser!.uid,
        userName: _currentUser!.userName,
        email: _currentUser!.email,
        phoneNumber: _currentUser!.phoneNumber,
        profilePic: imageUrl,
      );
      notifyListeners();
    }
  }

  Future<void> uploadAndUpdateProfilePic(File imageFile) async {
    if (_currentUser == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final String? imageUrl = await SupabaseService().uploadProfileImage(
        imageFile: imageFile,
        uid: _currentUser!.uid,
        userName: _currentUser!.userName,
      );

      if (imageUrl != null) {
        await FirestoreService().updateProfilePic(_currentUser!.uid, imageUrl);
        updateProfilePicLocally(imageUrl);
      }
    } catch (e) {
      debugPrint("Error updating profile picture: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProfilePic() async {
    if (_currentUser == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      // 1. Delete from Supabase
      await SupabaseService().deleteProfileImage(_currentUser!.uid);

      // 2. Update Firestore (set profilePic to empty string)
      await FirestoreService().updateProfilePic(_currentUser!.uid, "");

      // 3. Update local state
      updateProfilePicLocally("");
    } catch (e) {
      debugPrint("Error deleting profile picture: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUserAccount() async {
    if (_currentUser == null) return;
    _isLoading = true;
    notifyListeners();

    try {
      final uid = _currentUser!.uid;
      await FirestoreService().deleteUserEvents(uid);
      await SupabaseService().deleteProfileImage(uid);
      await FirestoreService().deleteUserData(uid);
      await FirebaseAuth.instance.currentUser?.delete();

      _currentUser = null;
    } catch (e) {
      debugPrint("Error deleting account: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
