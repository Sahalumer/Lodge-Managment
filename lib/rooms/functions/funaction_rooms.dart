import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/rooms/screens/add_persons.dart';

Future<void> selectImageSource(BuildContext context, VoidCallback onPressedOne,
    VoidCallback onPressedSecond) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
            height: MediaQuery.of(context).size.height * .12,
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: onPressedOne,
                    icon: const Icon(Icons.camera_enhance),
                    label: const Text("Camera")),
                TextButton.icon(
                    onPressed: onPressedSecond,
                    icon: const Icon(Icons.camera),
                    label: const Text("gallery"))
              ],
            )),
      );
    },
  );
}

Widget buildImagePreview(BuildContext context, VoidCallback onPressed) {
  return Column(
    children: [
      if (selectedImage != null)
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(selectedImage!)),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      const SizedBox(height: 10),
      ElevatedButton(
        onPressed: onPressed,
        child: const Text('Change Image'),
      ),
    ],
  );
}

toSelectDate(BuildContext context) {
  showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  ).then((selectedDate) {
    if (selectedDate != null) {
      monthControllerPrivate.text =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    }
  });
}
