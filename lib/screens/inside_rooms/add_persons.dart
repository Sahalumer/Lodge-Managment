import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/components/components.dart';
import 'package:project/databaseconnection/person_functions.dart';
import 'package:project/model/house_model.dart';

class AddPerson extends StatefulWidget {
  final int houseKey;
  final String roomName;

  const AddPerson({
    super.key,
    required this.houseKey,
    required this.roomName,
  });

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  final monthController = TextEditingController();
  bool isPayed = false;
  File? imagePath;
  String? selectedImage;

  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    amountController.text = '0';
    isSelected = List<bool>.filled(2, false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primary.color,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('Assets/Image/LogoImage.png'),
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.658,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17)),
                      color: AppColor.white.color,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .32,
                                    ),
                                    const Text(
                                      'Add Client',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: CustomTextField(
                                    labelText: "Name",
                                    hintText: "Enter The Name",
                                    controller: nameController,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: CustomTextField(
                                    labelText: "Phone Number",
                                    hintText: "Enter The Phone Number",
                                    controller: phoneController,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: CustomTextField(
                                    labelText: "Join Month",
                                    hintText: "dd/mm/year",
                                    controller: monthController,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Text('Add ID Proof'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      pickImageFromGallery();
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text('Add Image'),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .03,
                                    ),
                                    const Text(
                                      'Is Payment Completed',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ToggleButtons(
                                        isSelected: isSelected,
                                        onPressed: (int index) {
                                          setState(() {
                                            isPayed = index == 0;
                                            for (int buttonIndex = 0;
                                                buttonIndex < isSelected.length;
                                                buttonIndex++) {
                                              isSelected[buttonIndex] =
                                                  buttonIndex == index;
                                            }
                                          });
                                        },
                                        children: const [
                                          Text('Yes'),
                                          Text('No'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                if (isPayed)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 15),
                                    child: CustomTextField(
                                      labelText: 'Amount',
                                      hintText: 'Enter the Amount',
                                      controller: amountController,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                minimumSize: const Size(250, 53),
                                backgroundColor: AppColor.primary.color,
                              ),
                              onPressed: () {
                                onAddButton();
                              },
                              child: const Text(
                                'ADD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    setState(() {
      imagePath = File(pickedImage.path);
      selectedImage = pickedImage.path;
    });
  }

  void onAddButton() async {
    if (formKey.currentState!.validate()) {
      final person = Person(
          name: nameController.text,
          phoneNumber: int.parse(phoneController.text),
          imagePath: selectedImage!,
          isPayed: isPayed,
          joinDate: monthController.text,
          revenue: {monthController.text: int.parse(amountController.text)});
      await addPersonInRoomAsync(
        widget.houseKey,
        widget.roomName,
        person,
      );
      Navigator.pop(context);
    }
  }
}
