// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/floors/widgets/card.dart';
import 'package:project/floors/widgets/delete_functions.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/model/house_model.dart';
import 'package:project/floors/screens/edit_floors_rooms.dart';
import 'package:project/floors/screens/inside_floor.dart';
import 'package:project/floors/screens/payment_dues.dart';
import 'package:project/floors/screens/revenue.dart';
import 'package:project/widgets/custom_drawer.dart';
import 'package:project/widgets/custom_elavatedbutton.dart';
import 'package:project/widgets/my_appbar.dart';
import 'package:project/widgets/show_errors.dart';

class HouseHomePage extends StatefulWidget {
  final int houseKey;
  final String houseName;
  final String ownerName;
  const HouseHomePage(
      {super.key,
      required this.houseKey,
      required this.houseName,
      required this.ownerName});
  @override
  State<HouseHomePage> createState() => _HouseHomePageState();
}

class _HouseHomePageState extends State<HouseHomePage> {
  late Future<House> _houseFuture;
  @override
  void initState() {
    super.initState();
    _houseFuture = getHouseByKeyAsync(widget.houseKey);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: MyAppBar(
        onPressed: () {
          delete(context, widget.houseKey, widget.ownerName);
        },
        title: widget.houseName,
        iconData: Icons.delete,
      ),
      drawer: MyDrawer(
          onPressedOne: () async {
            House house = await getHouseByKeyAsync(widget.houseKey);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentDues(
                    house: house,
                  ),
                ));
          },
          onPressedSecond: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleHouseRevenue(
                      houseKey: widget.houseKey, houseName: widget.houseName),
                ));
          },
          textOne: 'Incompleted Payments',
          textSecond: 'Revenue'),
      body: FutureBuilder<House>(
        future: _houseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            int itemcount = snapshot.data!.floorCount;
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: itemcount + 1,
                  itemBuilder: (context, index) {
                    int floorName = index + 1;
                    final List<int> roomCount = [];
                    for (int i = 0; i < itemcount; i++) {
                      roomCount.add(snapshot.data!.roomCount[i].length);
                    }

                    if (index != itemcount) {
                      final bedSpace =
                          findBedSpaceAvailableByFloor(snapshot.data!);
                      return CardInInsideHouse(
                        title: 'Floor No: $floorName',
                        subtitle: '${bedSpace[index]} Bed Space Available ',
                        onpressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => InsideFloor(
                                        floorName: 'Floor No: $floorName',
                                        roomCount: roomCount[index],
                                        house: snapshot.data!,
                                        index: index,
                                      ))).then((value) {
                            if (value != null) {
                              setState(() {
                                _houseFuture =
                                    getHouseByKeyAsync(snapshot.data!.key);
                              });
                            } else {
                              setState(() {
                                _houseFuture =
                                    getHouseByKeyAsync(snapshot.data!.key);
                              });
                            }
                          });
                        },
                      );
                    } else {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomElevatedButton(
                            buttonText: "Edit The Floors And Rooms",
                            onPressed: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => EditFloorsAndRooms(
                                              house: snapshot.data!)))
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    _houseFuture =
                                        getHouseByKeyAsync(widget.houseKey);
                                  });
                                }
                              });
                            },
                          ));
                    }
                  },
                ));
          }
        },
      ),
    ));
  }
}
