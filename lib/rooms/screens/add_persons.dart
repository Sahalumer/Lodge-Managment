// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/databaseconnection/person_functions.dart';
import 'package:project/model/house_model.dart';
import 'package:project/rooms/functions/funaction_rooms.dart';
import 'package:project/rooms/widgets/button.dart';
import 'package:project/rooms/widgets/textfield.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/custom_textfield.dart';
import 'package:project/widgets/list_months.dart';
import 'package:project/widgets/scaffold_msg.dart';

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

File? imagePath;
String? selectedImage;
final monthControllerPrivate = TextEditingController();

class _AddPersonState extends State<AddPerson> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();

  String? selectedMonth;
  bool isPayed = false;

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
        backgroundColor: primary,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('Assets/Image/LogoImage.png'),
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.715,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17)),
                      color: white,
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
                                    width:
                                        MediaQuery.of(context).size.width * .32,
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
                              TextFieldInRoom(
                                  text: "Name",
                                  labelText: 'Name',
                                  hintText: "Enter The Name",
                                  controller: nameController,
                                  keyboard: TextInputType.name),
                              TextFieldInRoom(
                                  text: 'Phone Number',
                                  labelText: "Phone Number",
                                  hintText: "Enter The Phone Number",
                                  controller: phoneController,
                                  keyboard: TextInputType.phone),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Join Date'),
                                    InkWell(
                                      onTap: () {
                                        toSelectDate(context);
                                      },
                                      child: IgnorePointer(
                                        child: CustomTextField(
                                          labelText: "Join Month",
                                          hintText: "dd/mm/year",
                                          controller: monthControllerPrivate,
                                          keyboardType: null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text('ID Proof'),
                              ),
                              if (selectedImage == null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      selectImageSource(
                                        context,
                                        () {
                                          pickImageFromcamera();
                                          Navigator.pop(context);
                                        },
                                        () {
                                          pickImageFromGallery();
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text('Add Image'),
                                  ),
                                ),
                              if (selectedImage != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: buildImagePreview(
                                    context,
                                    () {
                                      selectImageSource(
                                        context,
                                        () {
                                          pickImageFromcamera();
                                          Navigator.pop(context);
                                        },
                                        () {
                                          pickImageFromGallery();
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .03,
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
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Month',
                                          ),
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
                                              fillColor: Color.fromARGB(
                                                  255, 217, 217, 217),
                                              hintText: "Select the Month",
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select the Month';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextFieldInRoom(
                                        text: "Amount",
                                        labelText: "Amount",
                                        hintText: 'Enter The Amount',
                                        controller: amountController,
                                        keyboard: TextInputType.number)
                                  ],
                                ),
                            ],
                          )),
                        ),
                        AddButtonInRoom(onPressed: () => _onAddButton())
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

  Future<void> pickImageFromcamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;

    setState(() {
      imagePath = File(pickedImage.path);
      selectedImage = pickedImage.path;
    });
  }

  _onAddButton() async {
    if (formKey.currentState!.validate()) {
      if (selectedImage == null) {
        showScaffoldMsg(context, 'Please add the Id Proof');
      }

      final person = Person(
          name: nameController.text,
          phoneNumber: int.parse(phoneController.text),
          imagePath: selectedImage!,
          isPayed: isPayed,
          roomName: widget.roomName,
          joinDate: monthControllerPrivate.text,
          revenue: {
            isPayed ? selectedMonth! : '': int.parse(amountController.text),
          });
      await addPersonInRoomAsync(
        widget.houseKey,
        widget.roomName,
        person,
      );
      Navigator.pop(context);
    }
  }
}
