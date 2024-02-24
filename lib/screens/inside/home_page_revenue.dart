import 'package:flutter/material.dart';
import 'package:project/components/components.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/model/house_model.dart';

class AllHouseRevenue extends StatefulWidget {
  final List<House> houses;
  final String name;
  const AllHouseRevenue({super.key, required this.houses, required this.name});

  @override
  State<AllHouseRevenue> createState() => _AllHouseRevenueState();
}

class _AllHouseRevenueState extends State<AllHouseRevenue> {
  late Future<List<House>> _houseFuture;
  int totalRevenue = 0;
  int totalMonthRevenue = 0;
  String selectedMonth = 'January';

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

  @override
  void initState() {
    super.initState();
    _houseFuture = loadHouse();
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
          title: Text(widget.name),
        ),
        body: FutureBuilder<List<House>>(
          future: _houseFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              totalRevenue = _calculateTotalRevenue(snapshot.data!);
              totalMonthRevenue = _calculateMonthRevenue(snapshot.data!);
              return Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * .28,
                  width: MediaQuery.of(context).size.width * .8,
                  color: AppColor.primary.color,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Total Revenue: $totalRevenue',
                        style: TextStyle(
                          color: AppColor.white.color,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          value: selectedMonth,
                          items: months.map((String month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(month),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedMonth = value!;
                            });
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Total Revenue in $selectedMonth : $totalMonthRevenue',
                          style: TextStyle(
                            color: AppColor.white.color,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<House>> loadHouse() async {
    return await getAllHousesByOwnerAsync(widget.name);
  }

  int _calculateTotalRevenue(List<House> houses) {
    int total = 0;
    for (var house in houses) {
      for (var floor in house.roomCount) {
        for (var room in floor) {
          for (var person in room.persons) {
            total += person.countTotal();
          }
        }
      }
    }

    return total;
  }

  int _calculateMonthRevenue(List<House> houses) {
    int total = 0;
    for (var house in houses) {
      for (var floor in house.roomCount) {
        for (var room in floor) {
          for (var person in room.persons) {
            total += person.countMonth(selectedMonth);
          }
        }
      }
    }
    return total;
  }
}
