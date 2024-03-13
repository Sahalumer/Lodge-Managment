// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/databaseconnection/person_functions.dart';
import 'package:project/model/house_model.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/custom_textButton.dart';

updatePayment(
    BuildContext context, Person data, int houseKey, String roomName) {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  String? selectedMonth;

  bool ispayed = true;
  amountController.text = '0';
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: primary,
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                const Text(
                  "Month",
                  style: TextStyle(color: white, fontSize: 18),
                ),
                const SizedBox(height: 2),
                DropdownButtonFormField(
                  value: selectedMonth,
                  items: months.map((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    selectedMonth = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 217, 217, 217),
                    hintText: "Select the Month",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the Month';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                const Text(
                  "Amount",
                  style: TextStyle(color: white, fontSize: 18),
                ),
                const SizedBox(height: 2),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(255, 217, 217, 217),
                    hintText: "Enter the Amount",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          CustomTextButton(
            buttonText: 'Cancel',
            onPressed: () => Navigator.pop(context),
          ),
          CustomTextButton(
            buttonText: 'Update',
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                if (amountController.text == "0") {
                  ispayed = false;
                }
                final updatedPerson = Person(
                  name: data.name,
                  phoneNumber: data.phoneNumber,
                  imagePath: data.imagePath,
                  isPayed: ispayed,
                  roomName: data.roomName,
                  joinDate: data.joinDate,
                  revenue: {
                    ...data.revenue,
                    selectedMonth!: int.parse(amountController.text)
                  },
                );

                await updatePersonInRoomAsync(
                    houseKey, roomName, updatedPerson);
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}
