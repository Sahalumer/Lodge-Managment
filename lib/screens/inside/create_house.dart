// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project/components/components.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/model/house_model.dart';
import 'package:project/screens/inside/Home.dart';

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
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
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
                    height: 509,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17)),
                      color: Color.fromARGB(255, 1, 33, 90),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Create House',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: CustomTextField(
                                      labelText: "House Name",
                                      hintText: "Enter The House Name",
                                      controller: houseNameController,
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: CustomTextField(
                                      labelText: "Floor Count",
                                      hintText: "Enter The Floor Count",
                                      controller: floorCountController,
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                for (int i = 0;
                                    i < roomCountControllers.length;
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 15),
                                    child: CustomTextField(
                                        labelText: "Room Count ${i + 1}",
                                        hintText:
                                            'Rooms Count In Floor ${i + 1}',
                                        controller: roomCountControllers[i]),
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
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {
                                onCreateButton(context);
                              },
                              child: const Text(
                                'Create House',
                                style: TextStyle(
                                  color: Colors.black,
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

  void _updateRoomCountControllers() {
    int currentRoomCount = int.tryParse(roomCount) ?? 0;
    roomCountControllers = List.generate(
      currentRoomCount,
      (index) => TextEditingController(),
    );
  }

  onCreateButton(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final houseName = houseNameController.text.trim();
      final floorCount = floorCountController.text.trim();
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
