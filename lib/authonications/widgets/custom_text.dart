import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  const CustomText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: white),
    );
  }
}
