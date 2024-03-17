import 'package:flutter/material.dart';

class BuildCreateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BuildCreateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: const Size(250, 53),
        backgroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: const Text(
        'Create House',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }
}
