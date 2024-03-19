import 'package:project/model/house_model.dart';

int calculateTotalRevenue(House house) {
  int total = 0;
  for (var floor in house.roomCount) {
    for (var room in floor) {
      for (var person in room.persons) {
        total += person.countTotal();
      }
    }
  }
  return total;
}

int calculateMonthRevenue(House house, String selectedMonth) {
  int total = 0;
  for (var floor in house.roomCount) {
    for (var room in floor) {
      for (var person in room.persons) {
        total += person.countMonth(selectedMonth);
      }
    }
  }
  return total;
}
