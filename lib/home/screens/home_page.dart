// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/home/widgets/card.dart';
import 'package:project/model/house_model.dart';
import 'package:project/authonications/screens/login_page.dart';
import 'package:project/home/screens/create_house.dart';
import 'package:project/floors/screens/inside_house.dart';
import 'package:project/privacy_terms/terms_and_privacy/privacy.dart';
import 'package:project/widgets/custom_drawer.dart';
import 'package:project/widgets/my_appBar.dart';
import 'package:project/widgets/scaffold_msg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final String ownerName;
  final List<House> house;
  const HomePage({super.key, required this.house, required this.ownerName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: "Houses",
          onPressed: () {
            _inLogedOutButton(context);
          },
          iconData: Icons.logout_outlined,
        ),
        drawer: MyDrawer(
            onPressedOne: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          Privacy(mdFileName: 'privacy_policy.md')));
            },
            onPressedSecond: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) =>
                          Privacy(mdFileName: 'privacy_policy.md')));
            },
            textOne: 'Privacy & Policy',
            textSecond: 'About'),
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
                return CardHome(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => HouseHomePage(
                                    houseKey: data.key,
                                    houseName: data.houseName,
                                    ownerName: data.ownerName,
                                  )));
                    },
                    name: data.houseName);
              } else {
                return CardHome(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => CreateHouse(name: ownerName),
                    ),
                  );
                });
              }
            },
          ),
        ),
      ),
    );
  }

  _inLogedOutButton(BuildContext context) {
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
                showScaffoldMsg(context, "Logouted From Your Account");
              })
        ],
      ),
    );
  }
}
