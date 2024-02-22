// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/screens/Authonications/login_page.dart';
import 'package:project/screens/inside/Home.dart';
import 'package:project/screens/inside/first_sign_in.dart';
import 'package:project/screens/inside/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    splashScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 33, 90),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('Assets/Logo/Logo.png'),
            const SizedBox(
              height: 50,
            ),
            Image.asset('Assets/Image/Splash Screen.png'),
            const SizedBox(
              height: 50,
            ),
          ],
        )),
      ),
    );
  }

  splashScreen(BuildContext ctx) async {
    await Future.delayed(const Duration(seconds: 3));
    final sahredprefes = await SharedPreferences.getInstance();

    final savedvalue = sahredprefes.getString('value');
    if (savedvalue != null) {
      print(savedvalue);
      await getAllHousesByOwnerAsync(savedvalue);
      if (houseList.value.isEmpty) {
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (ctx) => FirstSignIn(name: savedvalue)));
      } else {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => Home(name: savedvalue),
          ),
        );
      }
    }
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => LoginPage(),
      ),
    );
  }
}
