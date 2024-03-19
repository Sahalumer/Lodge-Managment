import 'package:project/model/house_model.dart';

int calculateTotalRevenue(List<House> houses) {
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

int calculateMonthRevenue(List<House> houses, String selectedMonth) {
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
