import 'package:flutter/material.dart';
import 'package:firebase_authv1_isidro/components/my_button.dart';
import 'package:firebase_authv1_isidro/components/my_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 90),
                SizedBox(
                  height: 150.0,
                  child: Image.asset(
                    'lib/assets/images/penguin.png',
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    MyTextField(
                      controller: usernameController,
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
                  textColor: const Color(0xFFD1D1D1),
                  borderColor: const Color(0xFF2B2E38),
                  onTap: () {},
                ),
                const SizedBox(height: 26),
                MyButton(
                  buttonText: "Sign Up",
                  buttonColor: const Color.fromARGB(255, 117, 117, 117),
                  textColor: const Color(0xFF2B2E38),
                  borderColor: const Color.fromARGB(255, 117, 117, 117),
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
