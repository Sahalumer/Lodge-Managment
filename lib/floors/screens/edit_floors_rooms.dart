// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/databaseconnection/person_functions.dart';
import 'package:project/floors/widgets/textfield_floors.dart';
import 'package:project/model/house_model.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/custom_textbutton.dart';

class EditFloorsAndRooms extends StatefulWidget {
  final House house;
  const EditFloorsAndRooms({super.key, required this.house});
  @override
  State<EditFloorsAndRooms> createState() => _EditFloorsAndRoomsState();
}

class _EditFloorsAndRoomsState extends State<EditFloorsAndRooms> {
  final formKey = GlobalKey<FormState>();
  final newFloorCountController = TextEditingController();
  List<TextEditingController> newRoomCountControllers = [];

  @override
  void initState() {
    super.initState();
    _assignValue();
    newFloorCountController.addListener(() {
      setState(() {
        _updateRoomCountControllers();
      });
    });
  }

  @override
  void dispose() {
    newFloorCountController.dispose();
    for (var controller in newRoomCountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: primary,
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldInFloor(
                      controller: newFloorCountController,
                      labelText: "Floor Count",
                      hintText: "Enter The Floor Count",
                      text: 'Floor Count',
                    ),
                    for (int i = 0; i < newRoomCountControllers.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldInFloor(
                            controller: newRoomCountControllers[i],
                            labelText: 'Room Count',
                            hintText: "Enter The Room Count",
                            text: 'Room Count in Floor ${i + 1}',
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                          buttonText: 'Back',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CustomTextButton(
                          buttonText: "Update",
                          onPressed: () {
                            _inUpdateButton();
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  _assignValue() {
    newFloorCountController.text = widget.house.floorCount.toString();
    _updateRoomCountControllers();
    for (int i = 0; i < newRoomCountControllers.length; i++) {
      newRoomCountControllers[i].text = i < widget.house.roomCount.length
          ? widget.house.roomCount[i].length.toString()
          : '';
    }
  }

  _updateRoomCountControllers() {
    int currentRoomCount = int.tryParse(newFloorCountController.text) ?? 0;
    setState(() {
      if (currentRoomCount > newRoomCountControllers.length) {
        newRoomCountControllers.addAll(
          List.generate(
            currentRoomCount - newRoomCountControllers.length,
            (index) => TextEditingController(
              text: index < widget.house.roomCount.length
                  ? widget.house.roomCount[index].length.toString()
                  : '',
            ),
          ),
        );
      } else {
        newRoomCountControllers.removeRange(
          currentRoomCount,
          newRoomCountControllers.length,
        );
      }
    });
  }

  _inUpdateButton() async {
    if (formKey.currentState!.validate()) {
      final houseName = widget.house.houseName;
      final ownerName = widget.house.ownerName;
      final floorCount = newFloorCountController.text.trim();
      final roomCount = newRoomCountControllers
          .map((controller) => controller.text.trim())
          .toList();
      final List<List<Room>> rooms = [];
      for (int i = 0; i < roomCount.length; i++) {
        int count = int.parse(roomCount[i]);
        List<Room> value = [];
        for (int j = 0; j < count; j++) {
          List<Person> persons =
              await getPersonsByRoomName(widget.house.key, '$i-$j-$houseName');
          Room temp = Room(
              roomName: '$i-$j-$houseName',
              persons: persons.isEmpty ? [] : persons,
              bedSpaceCount: persons.isEmpty ? 1 : persons.length);
          value.add(temp);
        }
        rooms.add(value);
      }
      final updatedHouse = House(
          houseName: houseName,
          floorCount: int.parse(floorCount),
          roomCount: rooms,
          ownerName: ownerName);
      await updateHouseAsync(widget.house.key, updatedHouse);
      Navigator.pop(context, updatedHouse);
    }
  }
}
