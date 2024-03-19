import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/custom_textfield.dart';

class TextFieldInFloor extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String text;
  const TextFieldInFloor(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(color: white),
        ),
        const SizedBox(height: 5),
        CustomTextField(
          labelText: labelText,
          hintText: hintText,
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
