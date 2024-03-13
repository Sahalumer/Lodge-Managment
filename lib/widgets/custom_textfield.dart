// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String? hintText;
  String? labelText;
  TextEditingController? controller;
  TextInputType? keyboardType;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: const Color.fromARGB(255, 217, 217, 217),
          hintText: hintText,
          labelText: null,
          labelStyle: const TextStyle(
            color: Colors.black,
          )),
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText is empty';
        } else {
          return null;
        }
      },
    );
  }
}
