import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );
  
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Check if Firebase is available
  static bool get isFirebaseAvailable => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  // Get current user
  static User? get currentUser => isFirebaseAvailable ? _auth.currentUser : null;

  // Stream of auth state changes
  static Stream<User?> get authStateChanges => 
      isFirebaseAvailable ? _auth.authStateChanges() : Stream.value(null);

  // Sign in with Google
  static Future<UserCredential?> signInWithGoogle() async {
    if (!isFirebaseAvailable) {
      throw Exception('Google Sign-In is only available on Android and iOS platforms');
    }
    
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      rethrow;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  // Check if user is signed in
  static bool get isSignedIn => _auth.currentUser != null;

  // Get user display name
  static String? get userDisplayName => _auth.currentUser?.displayName;

  // Get user email
  static String? get userEmail => _auth.currentUser?.email;

  // Get user photo URL
  static String? get userPhotoURL => _auth.currentUser?.photoURL;

  // Sign in with email and password
  static Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print('Error signing in with email: $e');
      rethrow;
    }
  }

  // Create user with email and password
  static Future<UserCredential> createUserWithEmailAndPassword(String email, String password, String name) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the user's display name
      await userCredential.user?.updateDisplayName(name);
      
      return userCredential;
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }
}
