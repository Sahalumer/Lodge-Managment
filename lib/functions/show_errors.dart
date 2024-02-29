import 'package:project/databaseconnection/house_db.dart';
import 'package:project/model/house_model.dart';

Future<List<int>> findBedSpaceAvailableByFloor(int houseKey) async {
  List<int> count = [];
  House house = await getHouseByKeyAsync(houseKey);
  for (var rooms in house.roomCount) {
    int temp = rooms.fold(0, (sum, e) => sum + e.bedSpaceCount);
    int personCount = rooms.fold(0, (sum, e) => sum + e.persons.length);
    count.add(temp - personCount);
  }
  return count;
}
