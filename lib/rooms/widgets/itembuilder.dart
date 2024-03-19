import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';

class ItemBuilderInRoom extends StatelessWidget {
  final String name;
  final Color color;
  final String phoneNumber;
  const ItemBuilderInRoom(
      {super.key,
      required this.name,
      required this.color,
      required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Image.asset(
              'Assets/Image/users.png',
              height: 100,
            ),
            Text(
              name,
              style: TextStyle(color: color),
            ),
            Text(
              phoneNumber,
              style: TextStyle(color: color),
            )
          ],
        ),
      ),
    );
  }
}
