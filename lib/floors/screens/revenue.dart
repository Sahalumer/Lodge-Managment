import 'package:flutter/material.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/floors/functions/function_floor.dart';
import 'package:project/model/house_model.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/list_months.dart';

class SingleHouseRevenue extends StatefulWidget {
  final int houseKey;
  final String houseName;
  const SingleHouseRevenue(
      {super.key, required this.houseKey, required this.houseName});

  @override
  State<SingleHouseRevenue> createState() => _SingleHouseRevenueState();
}

class _SingleHouseRevenueState extends State<SingleHouseRevenue> {
  late Future<House> _houseFuture;
  int totalRevenue = 0;
  int totalMonthRevenue = 0;
  String selectedMonth = 'January';

  @override
  void initState() {
    super.initState();
    _houseFuture = _loadHouse();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          centerTitle: true,
          foregroundColor: white,
          toolbarHeight: 65,
          title: Text(widget.houseName),
        ),
        body: FutureBuilder<House>(
          future: _houseFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              totalRevenue = calculateTotalRevenue(snapshot.data!);
              totalMonthRevenue =
                  calculateMonthRevenue(snapshot.data!, selectedMonth);
              return Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * .28,
                  width: MediaQuery.of(context).size.width * .8,
                  color: primary,
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        'Total Revenue: $totalRevenue',
                        style: const TextStyle(
                          color: white,
                          fontSize: 20,
                        ),
                      ),
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
                          'Total Revenue of $selectedMonth : $totalMonthRevenue',
                          style: const TextStyle(
                            color: white,
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

  Future<House> _loadHouse() async {
    return await getHouseByKeyAsync(widget.houseKey);
  }
}
