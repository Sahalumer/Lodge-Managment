import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/custom_elavatedbutton.dart';

class AddButtonInRoom extends StatelessWidget {
  final VoidCallback onPressed;
  const AddButtonInRoom({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            minimumSize: const Size(250, 53),
            backgroundColor: primary,
          ),
          onPressed: onPressed,
          child: const Text(
            'ADD',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class DoneButtonInRoom extends StatelessWidget {
  const DoneButtonInRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: CustomElevatedButton(
        buttonText: 'DONE',
        onPressed: () => Navigator.pop(
          context,
        ),
      ),
    );
  }
}
