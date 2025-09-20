import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' show Platform;
import 'auth_screen.dart';
import 'main_navigation.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // If not on mobile platforms, go directly to main navigation
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      return const MainNavigation();
    }
    
    // On mobile platforms, use Firebase auth
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading indicator while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF055d69)),
              ),
            ),
          );
        }
        
        // Show main app if user is logged in, otherwise show auth screen
        if (snapshot.hasData && snapshot.data != null) {
          return const MainNavigation();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
