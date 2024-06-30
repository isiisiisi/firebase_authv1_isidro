import 'package:flutter/material.dart';
import 'package:firebase_authv1_isidro/components/my_button.dart';
import 'package:firebase_authv1_isidro/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    }
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
                const SizedBox(height: 80),
                SizedBox(
                  height: 150.0,
                  child: Image.asset(
                    'lib/assets/images/penguin.png',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to PenguinLand',
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
                const SizedBox(height: 55),
                MyButton(
                  buttonText: "Login",
                  buttonColor: const Color(0xFF2B2E38),
                  textColor: const Color(0xFFFFFFFF),
                  borderColor: const Color(0xFF2B2E38),
                  onTap: () => signUserIn(context),
                ),
                const SizedBox(height: 26),
                MyButton(
                  buttonText: "Sign Up",
                  buttonColor: const Color.fromARGB(255, 255, 255, 255),
                  textColor: const Color(0xFF2B2E38),
                  borderColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
