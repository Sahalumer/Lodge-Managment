import 'package:flutter/material.dart';

class ElevatedButtonInRoom extends StatelessWidget {
  final VoidCallback onPressed;
  const ElevatedButtonInRoom({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        minimumSize: const Size(210, 43),
        backgroundColor: Colors.white,
      ),
      child: const Text('Payment'),
    );
  }
}
