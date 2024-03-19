import 'package:flutter/material.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/home/functions/functions_home.dart';
import 'package:project/model/house_model.dart';
import 'package:project/floors/screens/payment_dues.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/list_months.dart';

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
              backgroundColor: primary,
              centerTitle: true,
              foregroundColor: white,
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
                  totalRevenue = calculateTotalRevenue(snapshot.data!);
                  totalMonthRevenue =
                      calculateMonthRevenue(snapshot.data!, selectedMonth);
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
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
                                      fillColor:
                                          Color.fromARGB(255, 217, 217, 217),
                                      hintText: "Select the Month",
                                      labelStyle:
                                          TextStyle(color: Colors.black),
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
                                      style: const TextStyle(
                                          color: white, fontSize: 20),
                                    )),
                              ],
                            )),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'View Incompleted Payments? ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => PaymentDues(
                                            houses: widget.houses)));
                              },
                              child: const Text(
                                "Click Here ",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: primary),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }
              },
            )));
  }

  Future<List<House>> loadHouse() async {
    return await getAllHousesByOwnerAsync(widget.name);
  }
}
