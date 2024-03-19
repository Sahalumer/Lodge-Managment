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

showDiologueInRoom(BuildContext context, VoidCallback onPressed,
    TextEditingController controller) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Enter Bed Space Count"),
      content: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: "Enter bed space count",
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: onPressed,
          child: const Text("Submit"),
        ),
      ],
    ),
  );
}

deleteFuncInRoom(BuildContext context, VoidCallback onPressed) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text(
          'Are You Confirm To Delete?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
