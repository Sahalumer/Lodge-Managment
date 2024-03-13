// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/model/house_model.dart';
import 'package:project/authonications/screens/login_page.dart';
import 'package:project/home/screens/create_house.dart';
import 'package:project/floors/screens/inside_house.dart';
import 'package:project/privacy_terms/terms_and_privacy/about.dart';
import 'package:project/privacy_terms/terms_and_privacy/privacy.dart';
import 'package:project/widgets/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final String ownerName;
  final List<House> house;
  const HomePage({super.key, required this.house, required this.ownerName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          centerTitle: true,
          foregroundColor: white,
          toolbarHeight: 65,
          title: const Text('Houses'),
          actions: [
            IconButton(
              onPressed: () {
                inLogedOutButton(context);
              },
              icon: const Icon(Icons.logout_outlined),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: primary,
                ),
                child: Image.asset('Assets/Image/LogoImage.png'),
              ),
              ListTile(
                title: const Text('Privacy & Policy'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              Privacy(mdFileName: 'privacy_policy.md')));
                },
              ),
              ListTile(
                title: const Text('About'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => AboutScreen()));
                },
              ),
            ],
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: houseList,
          builder:
              (BuildContext context, List<House> listHouse, Widget? child) =>
                  GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 18,
            ),
            itemCount: listHouse.length + 1,
            itemBuilder: (context, index) {
              if (index != listHouse.length) {
                final data = listHouse[index];
                return Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => HouseHomePage(
                                    houseKey: data.key,
                                    houseName: data.houseName,
                                    ownerName: data.ownerName,
                                  )));
                    },
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.home,
                            size: 80,
                          ),
                        ),
                        Text(data.houseName)
                      ],
                    ),
                  ),
                );
              } else {
                return Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => CreateHouse(name: ownerName),
                        ),
                      );
                    },
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 90,
                        weight: 10,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  inLogedOutButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text("Are You Confirm To Logout"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                final sharedprefre = await SharedPreferences.getInstance();
                await sharedprefre.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => LoginPage(),
                    ),
                    (route) => false);
                msg(context);
              })
        ],
      ),
    );
  }

  void msg(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Logouted From Your Account",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
