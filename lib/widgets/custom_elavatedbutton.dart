import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomElevatedButton(
      {super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        minimumSize: const Size(350, 43),
        backgroundColor: Colors.white,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
