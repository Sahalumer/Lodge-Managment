import 'package:flutter/material.dart';
import 'package:project/components/components.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/model/house_model.dart';
import 'package:project/screens/inside/home.dart';
import 'package:project/screens/inside_house/inside_floor.dart';
import 'package:project/screens/inside_house/revenue.dart';

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
  final roomCountCountroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late Future<House> _houseFuture;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    _houseFuture = getHouseByKeyAsync(widget.houseKey);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary.color,
          centerTitle: true,
          foregroundColor: AppColor.white.color,
          toolbarHeight: 65,
          title: Text(widget.houseName),
          actions: [
            IconButton(
              onPressed: () {
                delete(context);
              },
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColor.primary.color,
                ),
                child: Image.asset('Assets/Image/LogoImage.png'),
              ),
              ListTile(
                title: Text('Peynment Dues'),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => AboutPage(),
                  //     ));
                },
              ),
              ListTile(
                title: Text('Revenue'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleHouseRevenue(
                            houseKey: widget.houseKey,
                            houseName: widget.houseName),
                      ));
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            setState(() {
              _houseFuture = getHouseByKeyAsync(widget.houseKey);
            });
          },
          child: FutureBuilder<House>(
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
                        return Card(
                          color: AppColor.primary.color,
                          elevation: 5,
                          child: ListTile(
                            title: Text(
                              'Floor No: $floorName',
                              style: TextStyle(
                                color: AppColor.white.color,
                                fontSize: 18,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => InsideFloor(
                                            floorName: 'Floor No: $floorName',
                                            roomCount: roomCount[index],
                                            house: snapshot.data!,
                                            index: index,
                                          )));
                            },
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomElevatedButton(
                            buttonText: "Add Floor",
                            onPressed: () {
                              addFloor(snapshot.data!);
                            },
                          ),
                        );
                      }
                    },
                  ),
                );
              }
            },
          ),
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
                await deleteHouseAsync(widget.houseKey);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => Home(name: widget.ownerName)),
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
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Deletd Your  House",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.grey,
      ),
    );
  }

  addFloor(House house) {
    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            backgroundColor: AppColor.primary.color,
            title: Text(
              "How Many Rooms Are There? ",
              style: TextStyle(color: AppColor.white.color),
            ),
            content: SizedBox(
              height: 65,
              child: Column(
                children: [
                  CustomTextField(
                      labelText: 'How many Rooms',
                      hintText: 'Room Count',
                      controller: roomCountCountroller)
                ],
              ),
            ),
            actions: [
              CustomTextButton(
                buttonText: 'Cancel',
                onPressed: () => Navigator.pop(context),
              ),
              CustomTextButton(
                buttonText: 'Update',
                onPressed: () {
                  inUpdateButton(house);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  inUpdateButton(House house) async {
    if (formKey.currentState!.validate()) {
      final houseName = house.houseName;
      final ownerName = house.ownerName;

      final floorCount = house.floorCount + 1;

      final count = int.parse(roomCountCountroller.text);
      final List<Room> rooms = [];
      for (int j = 0; j < count; j++) {
        Room temp = Room(
            roomName: '${house.floorCount + 1}+$j+$houseName',
            persons: [],
            bedSpaceCount: 1);
        rooms.add(temp);
      }
      final List<List<Room>> updatedRoomCount = List.from(house.roomCount);
      updatedRoomCount.add(rooms);
      final updatedHouse = House(
        houseName: houseName,
        floorCount: floorCount,
        roomCount: updatedRoomCount,
        ownerName: ownerName,
      );
      await updateHouseAsync(widget.houseKey, updatedHouse);
      setState(() {
        _houseFuture = getHouseByKeyAsync(widget.houseKey);
      });
      Navigator.pop(context);
      _refreshIndicatorKey.currentState?.show();
    }
  }
}
