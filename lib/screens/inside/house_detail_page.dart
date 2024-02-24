// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/components/components.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/model/house_model.dart';
import 'package:project/screens/inside/home.dart';
import 'package:project/screens/inside_rooms/inside_room.dart';

class HouseDetailsPage extends StatelessWidget {
  final House house;
  const HouseDetailsPage({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    final int floorCount = int.parse(house.floorCount);
    final List<int> roomCount = [];
    for (int i = 0; i < floorCount; i++) {
      roomCount.add(house.roomCount[i].length);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary.color,
          centerTitle: true,
          foregroundColor: AppColor.white.color,
          toolbarHeight: 65,
          title: Text(house.houseName),
          actions: [
            IconButton(
              onPressed: () {
                delete(context);
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: (floorCount == 0)
            ? const Center(child: Text('No floor available'))
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: floorCount,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColor.primary.color,
                    ),
                    height: 380,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          'Floor ${index + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                            ),
                            itemCount: roomCount[index],
                            itemBuilder: (context, gridIndex) {
                              return InkWell(
                                onTap: () {
                                  List<Room> room = house.roomCount[index];

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => InsideRoom(
                                                roomName:
                                                    room[gridIndex].roomName,
                                                house: house,
                                              )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Column(
                                    children: [
                                      SizedBox(
                                        height: 17,
                                      ),
                                      Icon(
                                        Icons.touch_app,
                                        size: 90,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Tap To View',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  delete(BuildContext context) {
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
              onPressed: () async {
                await deleteHouseAsync(house.key);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => Home(name: house.ownerName)),
                    (route) => false);
                msg(context);
              },
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

  void msg(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Deletd Your ${house.houseName} House",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
