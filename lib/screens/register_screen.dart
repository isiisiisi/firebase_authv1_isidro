import 'package:flutter/material.dart';
import 'package:firebase_authv1_isidro/components/my_button.dart';
import 'package:firebase_authv1_isidro/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      _showDialog("Error", "Passwords do not match.");
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      if (e is FirebaseAuthException) {
        String errorMessage = getMessageFromErrorCode(e.code);
        _showDialog("Error", errorMessage);
      } else {
        _showDialog("Error", "An error occurred: ${e.toString()}");
      }
    }
  }

  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong password.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Server error, please try again later.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Registration failed. Please try again.";
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 60),
                SizedBox(
                  height: 100.0,
                  child: Image.asset(
                    'lib/assets/images/penguin.png',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF2B2E38),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                  ],
                ),
                const SizedBox(height: 23),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                  ],
                ),
                const SizedBox(height: 23),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                    ),
                  ],
                ),
                const SizedBox(height: 55),
                MyButton(
                  buttonText: "Sign Up",
                  buttonColor: const Color(0xFF2B2E38),
                  textColor: const Color(0xFFFFFFFF),
                  borderColor: const Color(0xFF2B2E38),
                  onTap: signUserUp,
                ),
                const SizedBox(height: 26),
                MyButton(
                  buttonText: "Login",
                  buttonColor: const Color.fromARGB(255, 255, 255, 255),
                  textColor: const Color(0xFF2B2E38),
                  borderColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: widget.onTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
