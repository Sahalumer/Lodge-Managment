import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';

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

class ElevattedButtonInDetails extends StatelessWidget {
  const ElevattedButtonInDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: const Size(250, 53),
        backgroundColor: primary,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Done',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
