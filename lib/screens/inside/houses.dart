import 'package:flutter/material.dart';
import 'package:project/components/components.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/model/house_model.dart';
import 'package:project/screens/inside/house_detail_page.dart';
import 'package:project/screens/inside/single_house_revenue.dart';

class Houses extends StatefulWidget {
  final House housee;
  const Houses({super.key, required this.housee});

  @override
  State<Houses> createState() => _HousesState();
}

class _HousesState extends State<Houses> {
  final formKey = GlobalKey<FormState>();
  final newFloorCountController = TextEditingController();
  List<TextEditingController> newRoomCountControllers = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    assignValue();
    newFloorCountController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateRoomCountControllers();
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
    final List<Widget> pages = [
      HouseDetailsPage(house: widget.housee),
      Container(),
      SingleHouseRevenue(
          houseKey: widget.housee.key, houseName: widget.housee.houseName),
    ];
    return SafeArea(
      child: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              label: 'Edit',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.wallet,
                color: Colors.white,
              ),
              label: 'Revenue',
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 1, 33, 90),
          selectedLabelStyle: const TextStyle(color: Colors.white),
          unselectedLabelStyle: const TextStyle(color: Colors.white),
          onTap: (index) {
            if (index == 1) {
              updateFloorsAndRooms();
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
        ),
      ),
    );
  }

  assignValue() {
    newFloorCountController.text = widget.housee.floorCount;
    updateRoomCountControllers();
    for (int i = 0; i < newRoomCountControllers.length; i++) {
      newRoomCountControllers[i].text = i < widget.housee.roomCount.length
          ? widget.housee.roomCount[i].length.toString()
          : '';
    }
  }

  updateFloorsAndRooms() {
    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: StatefulBuilder(
            builder: (context, setState) {
              newFloorCountController.addListener(() {
                setState(() {
                  updateRoomCountControllers();
                });
              });

              return AlertDialog(
                backgroundColor: AppColor.primary.color,
                title: Text(
                  'Update Room and Floor Counts',
                  style: TextStyle(color: AppColor.white.color),
                ),
                content: SizedBox(
                  height: 150,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: newFloorCountController,
                          hintText: "Floor Count",
                          labelText: "Enter The Floor Count",
                        ),
                        for (int i = 0; i < newRoomCountControllers.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: CustomTextField(
                              labelText: "Room Count ${i + 1}",
                              hintText: 'Rooms Count In Floor ${i + 1}',
                              controller: newRoomCountControllers[i],
                            ),
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
                    onPressed: () {
                      inUpdateButton();
                      // Add your logic for updating the data
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  updateRoomCountControllers() {
    int currentRoomCount = int.tryParse(newFloorCountController.text) ?? 0;
    setState(() {
      if (currentRoomCount > newRoomCountControllers.length) {
        newRoomCountControllers.addAll(
          List.generate(
            currentRoomCount - newRoomCountControllers.length,
            (index) => TextEditingController(
              text: index < widget.housee.roomCount.length
                  ? widget.housee.roomCount[index].length.toString()
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

  inUpdateButton() {
    if (formKey.currentState!.validate()) {
      final houseName = widget.housee.houseName;
      final ownerName = widget.housee.ownerName;
      final floorCount = newFloorCountController.text.trim();
      final roomCount = newRoomCountControllers
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
      final updatedHouse = House(
          houseName: houseName,
          floorCount: floorCount,
          roomCount: rooms,
          ownerName: ownerName);
      updateHouseAsync(widget.housee.key, updatedHouse);

      Navigator.pop(context, updatedHouse);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => Houses(housee: updatedHouse)),
      );
    }
  }
}
