import 'package:flutter/material.dart';

showScaffoldMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.grey,
    ),
  );
}
