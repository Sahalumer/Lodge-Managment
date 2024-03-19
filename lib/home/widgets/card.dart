// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final VoidCallback onPressed;
  String? name;
  CardHome({super.key, required this.onPressed, this.name});

  @override
  Widget build(BuildContext context) {
    return name != null
        ? Card(
            elevation: 5,
            child: InkWell(
              onTap: onPressed,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      Icons.home,
                      size: 80,
                    ),
                  ),
                  Text(name!)
                ],
              ),
            ),
          )
        : Card(
            elevation: 5,
            child: InkWell(
              onTap: onPressed,
              child: const Center(
                child: Icon(
                  Icons.add,
                  size: 90,
                  weight: 10,
                ),
              ),
            ),
          );
  }
}
