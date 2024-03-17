import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/custom_textfield.dart';

class TextFieldInHome extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboard;
  const TextFieldInHome(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      required this.keyboard});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(color: white),
          ),
          CustomTextField(
            labelText: labelText,
            hintText: hintText,
            controller: controller,
            keyboardType: keyboard,
          ),
        ],
      ),
    );
  }
}
