import 'package:project/model/house_model.dart';

List<int> findBedSpaceAvailableByFloor(House house) {
  return house.roomCount.map((rooms) {
    int temp = rooms.fold(0, (sum, e) => sum + e.bedSpaceCount);
    int personCount = rooms.fold(0, (sum, e) => sum + e.persons.length);
    return temp - personCount;
  }).toList();
}

List<int> findBedSpaceAvailablebyRooms(House house, int index) {
  List<int> counts = [];
  for (var rooms in house.roomCount) {
    for (var room in rooms) {
      counts.add(room.bedSpaceCount - room.persons.length);
    }
  }
  return counts;
}
