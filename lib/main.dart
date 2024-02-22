import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/model/admin_model.dart';
import 'package:project/model/house_model.dart';
import 'package:project/screens/Authonications/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(AdminEntryAdapter().typeId)) {
    Hive.registerAdapter(AdminEntryAdapter());
  }
  if (!Hive.isAdapterRegistered(HouseAdapter().typeId)) {
    Hive.registerAdapter(HouseAdapter());
    Hive.registerAdapter(PersonAdapter());
    Hive.registerAdapter(RoomAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Your Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Customize your theme further if needed
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
