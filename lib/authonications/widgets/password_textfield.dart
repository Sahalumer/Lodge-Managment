// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  String? password;
  PasswordTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.password});

  @override
  Widget build(BuildContext context) {
    return hintText == "Password"
        ? Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(255, 217, 217, 217),
                hintText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is Empty";
                } else if (value.length < 6) {
                  return "Minimum 6 Characters";
                } else {
                  return null;
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(255, 217, 217, 217),
                hintText: 'Re-Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Re-Password is Empty";
                } else if (value.length < 6) {
                  return "Minimum 6 Characters";
                } else if (value != password) {
                  return "Password doesn't match";
                } else {
                  return null;
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          );
  }
}
