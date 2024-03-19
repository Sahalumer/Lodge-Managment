import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';

class ShowInRowInRoom extends StatelessWidget {
  final String label;
  final String value;
  const ShowInRowInRoom({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class ShowInRowInDetails extends StatelessWidget {
  final String label;
  final String value;
  const ShowInRowInDetails(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
