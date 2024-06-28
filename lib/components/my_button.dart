import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor; 
  final Color textColor; 
  final Color borderColor; 
  final VoidCallback? onTap;

  const MyButton({
    super.key,
    required this.buttonText,
    this.buttonColor = const Color(0xFF2B2E38), 
    this.textColor = const Color(0xFFD1D4D1), 
    this.borderColor = const Color(0xFF2B2E38), 
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap?? () {}, 
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 40.0),
        decoration: BoxDecoration(
          color: buttonColor, 
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor), 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor, 
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}