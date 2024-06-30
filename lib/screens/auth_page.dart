import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authv1_isidro/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '/screens/home_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return HomeScreen();
          // Future.microtask(
          //     () => Navigator.of(context).pushReplacementNamed('/home'));
          // return const SizedBox.shrink();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
