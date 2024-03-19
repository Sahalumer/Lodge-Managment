// ignore_for_file: file_names, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/home/screens/home.dart';
import 'package:project/home/widgets/elevated_button_home.dart';
import 'package:project/home/widgets/textfield_home.dart';
import 'package:project/model/house_model.dart';
import 'package:project/widgets/colors.dart';

class CreateHouse extends StatefulWidget {
  final String name;
  const CreateHouse({Key? key, required this.name});
  @override
  State<CreateHouse> createState() => _CreateHouseState();
}

class _CreateHouseState extends State<CreateHouse> {
  final formKey = GlobalKey<FormState>();
  final houseNameController = TextEditingController();
  final floorCountController = TextEditingController();
  List<TextEditingController> roomCountControllers = [];
  String roomCount = '';

  @override
  void initState() {
    super.initState();
    _updateRoomCountControllers();
  }

  @override
  void dispose() {
    houseNameController.dispose();
    floorCountController.dispose();
    for (var controller in roomCountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    floorCountController.addListener(() {
      setState(() {
        roomCount = floorCountController.text;
        _updateRoomCountControllers();
      });
    });

    return SafeArea(
        child: Scaffold(
      backgroundColor: secondary,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              const SizedBox(
                width: 90,
              ),
              Image.asset('Assets/Image/createhose.png'),
            ],
          ),
          Form(
              key: formKey,
              child: SingleChildScrollView(
                  child: Container(
                      height: MediaQuery.of(context).size.height * .665,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17)),
                          color: primary),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Create House',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 30),
                                  TextFieldInHome(
                                      labelText: 'House Name',
                                      hintText: "Enter The House Name",
                                      controller: houseNameController,
                                      keyboard: TextInputType.name),
                                  TextFieldInHome(
                                      labelText: 'Floor Count',
                                      hintText: "Enter The Floor Count",
                                      controller: floorCountController,
                                      keyboard: TextInputType.number),
                                  for (int i = 0;
                                      i < roomCountControllers.length;
                                      i++)
                                    TextFieldInHome(
                                        labelText: 'Room Count ${i + 1}',
                                        hintText:
                                            'Room Counts In Floor ${i + 1}',
                                        controller: roomCountControllers[i],
                                        keyboard: TextInputType.number),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              BuildCreateButton(
                                  onPressed: () => _onCreateButton(context)),
                              const SizedBox(height: 20)
                            ],
                          )
                        ],
                      ))))
        ],
      )),
    ));
  }

  _updateRoomCountControllers() {
    int currentRoomCount = int.tryParse(roomCount) ?? 0;
    roomCountControllers = List.generate(
      currentRoomCount,
      (index) => TextEditingController(),
    );
  }

  _onCreateButton(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final houseName = houseNameController.text.trim();
      final floorCount = int.parse(floorCountController.text.trim());
      final roomCount = roomCountControllers
          .map((controller) => controller.text.trim())
          .toList();
      final List<List<Room>> rooms = [];
      for (int i = 0; i < roomCount.length; i++) {
        int count = int.parse(roomCount[i]);
        List<Room> value = [];
        for (int j = 0; j < count; j++) {
          Room temp =
              Room(roomName: '$i+$j+$houseName', persons: [], bedSpaceCount: 1);
          value.add(temp);
        }
        rooms.add(value);
      }
      final house = House(
        houseName: houseName,
        floorCount: floorCount,
        roomCount: rooms,
        ownerName: widget.name,
      );

      await addHouseAsync(house);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (ctx) => Home(
                  name: widget.name,
                )),
      );
    }
  }
}
