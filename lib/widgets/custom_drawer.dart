import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback onPressedOne;
  final VoidCallback onPressedSecond;
  final String textOne;
  final String textSecond;
  const MyDrawer(
      {super.key,
      required this.onPressedOne,
      required this.onPressedSecond,
      required this.textOne,
      required this.textSecond});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: primary,
            ),
            child: Image.asset('Assets/Image/LogoImage.png'),
          ),
          ListTile(title: const Text('Privacy & Policy'), onTap: onPressedOne),
          ListTile(title: const Text('About'), onTap: onPressedSecond),
        ],
      ),
    );
  }
}
