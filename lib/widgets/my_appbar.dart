import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  IconData? iconData;
  VoidCallback onPressed;
  final String title;
  MyAppBar(
      {super.key, this.iconData, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primary,
      centerTitle: true,
      foregroundColor: white,
      toolbarHeight: 65,
      title: Text(title),
      actions: [
        if (iconData != null)
          Visibility(
            visible: iconData != null,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(iconData),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
