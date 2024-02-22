import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/model/house_model.dart';

ValueNotifier<List<House>> houseList = ValueNotifier([]);
const String houseBoxName = "House Db";

Future<Box<House>> openHouseBox() async {
  return await Hive.openBox<House>(houseBoxName);
}

void closeHouseBox(Box<House>? box) async {
  if (box != null && box.isOpen) {
    await box.close();
  }
}

addHouseAsync(House house) async {
  final houseBox = await openHouseBox();
  try {
    await houseBox.add(house);
    await getAllHousesByOwnerAsync(house.ownerName);
  } finally {
    closeHouseBox(houseBox);
    houseList.notifyListeners();
  }
}

void getAllHouseAsync() async {
  final houseBox = await openHouseBox();
  try {
    houseList.value.clear();
    houseList.value.addAll(houseBox.values);
  } finally {
    closeHouseBox(houseBox);
    houseList.notifyListeners();
  }
}

Future<List<House>> getAllHousesByOwnerAsync(String ownerName) async {
  final houseBox = await openHouseBox();
  try {
    houseList.value.clear();
    houseList.value.addAll(
      houseBox.values.where((house) => house.ownerName == ownerName),
    );
    print('i found ${houseList.value.length} houses By Owner');
    return houseList.value;
  } finally {
    closeHouseBox(houseBox);
    houseList.notifyListeners();
  }
}

updateHouseAsync(int id, House updated) async {
  final houseBox = await openHouseBox();
  try {
    await houseBox.put(id, updated);
    await getAllHousesByOwnerAsync(updated.ownerName);
  } finally {
    if (houseBox != null && houseBox.isOpen) {
      await houseBox.close();
    }
  }
}

Future<House?> getHouseByNameAsync(String name) async {
  Box<House>? houseBox;

  try {
    houseBox = await openHouseBox();
    if (!houseBox.isOpen) {
      throw Exception('House box is not open');
    }

    final housename = houseBox.values.firstWhere(
      (entry) => entry.houseName == name,
      orElse: () => House(
        houseName: '',
        floorCount: '',
        roomCount: [],
        ownerName: '',
      ),
    );

    return housename.houseName.isNotEmpty ? housename : null;
  } catch (e) {
    print('Error in getHouseByNameAsync: $e');
    return null;
  } finally {
    closeHouseBox(houseBox);
  }
}

Future<House> getHouseByKeyAsync(int key) async {
  final houseBox = await openHouseBox();
  try {
    House? house = houseBox.get(key);
    return house!;
  } finally {
    closeHouseBox(houseBox);
  }
}

Future<void> deleteHouseAsync(int houseKey) async {
  final houseBox = await openHouseBox();
  try {
    houseBox.delete(houseKey);
  } finally {
    closeHouseBox(houseBox);
  }
}

Future<void> updateRoomBedSpaceCountAsync(
    int houseKey, String roomName, int newBedSpaceCount) async {
  final houseBox = await openHouseBox();

  try {
    House? house = houseBox.get(houseKey);
    Room? rooms;
    if (house != null) {
      for (var floor in house.roomCount) {
        for (var room in floor) {
          if (room.roomName == roomName) {
            rooms = room;
          }
        }
      }
    }

    if (rooms != null && house != null) {
      rooms.bedSpaceCount = newBedSpaceCount;
      await houseBox.put(houseKey, house);
      print('bedSpace Count Updated successfully');
    }
  } finally {
    if (houseBox.isOpen) {
      await houseBox.close();
    }
  }
}

Future<Room?> getRoomByNameInHouseAsync(int houseKey, String roomName) async {
  final houseBox = await openHouseBox();
  try {
    House? house = houseBox.get(houseKey);

    if (house != null) {
      for (var floor in house.roomCount) {
        for (var room in floor) {
          if (room.roomName == roomName) {
            return room;
          }
        }
      }
    }
    return null;
  } finally {
    closeHouseBox(houseBox);
  }
}
