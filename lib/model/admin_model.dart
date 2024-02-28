// ignore_for_file: file_names

import 'package:hive_flutter/hive_flutter.dart';
part 'admin_model.g.dart';

@HiveType(typeId: 1)
class AdminEntry {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  AdminEntry({required this.name, required this.email, required this.password});
}
