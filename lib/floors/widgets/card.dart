import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';

class CardInInsideHouse extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onpressed;
  const CardInInsideHouse(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primary,
      elevation: 5,
      child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: white,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              color: red,
              fontSize: 14,
            ),
          ),
          onTap: onpressed),
    );
  }
}
