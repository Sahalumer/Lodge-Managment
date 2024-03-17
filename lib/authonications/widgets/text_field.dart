import 'package:flutter/material.dart';
import 'package:project/authonications/widgets/custom_text.dart';
import 'package:project/widgets/custom_textfield.dart';
import 'package:project/widgets/validator.dart';

class TextFieldInAuhtonications extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboard;

  const TextFieldInAuhtonications({
    super.key,
    required this.text,
    required this.controller,
    required this.hintText,
    required this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return text == "Password"
        ? Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: text),
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 217, 217, 217),
                    hintText: hintText,
                    labelText: '',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  validator: Validators.passwordValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          )
        : text == 'Email'
            ? Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: text),
                    TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 217, 217, 217),
                          hintText: hintText,
                          labelText: '',
                          labelStyle: const TextStyle(color: Colors.black)),
                      validator: Validators.emailValidator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: text),
                    CustomTextField(
                      controller: controller,
                      hintText: hintText,
                      labelText: "",
                      keyboardType: keyboard,
                    ),
                  ],
                ),
              );
  }
}
