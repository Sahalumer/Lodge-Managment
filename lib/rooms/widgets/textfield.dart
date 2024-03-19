import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/custom_textfield.dart';

class TextFieldInRoom extends StatelessWidget {
  final String text;
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboard;
  const TextFieldInRoom(
      {super.key,
      required this.text,
      required this.labelText,
      required this.hintText,
      required this.controller,
      required this.keyboard});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
              ),
              CustomTextField(
                labelText: labelText,
                hintText: hintText,
                controller: controller,
                keyboardType: keyboard,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class TextFormFieldInRoom extends StatelessWidget {
  final TextEditingController controller;
  const TextFormFieldInRoom({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: secondary,
        hintText: "Enter the Amount",
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the amount';
        }
        return null;
      },
    );
  }
}
