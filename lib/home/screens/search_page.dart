// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/model/house_model.dart';
import 'package:project/floors/screens/inside_house.dart';
import 'package:project/rooms/screens/person_details.dart';
import 'package:project/widgets/show_errors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Person> _searchedPersons = [];
  List<House> _searchedHouses = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              hintText: 'Search..',
              icon: Icon(Icons.search),
            ),
            onChanged: (value) {
              _searchData(value);
            },
          ),
        ),
        body: _searchController.text.isEmpty
            ? const Center(child: Text('Search...'))
            : _searchedPersons.isEmpty && _searchedHouses.isEmpty
                ? const Center(child: Text('No data found'))
                : ListView.builder(
                    itemCount: _searchedPersons.length + _searchedHouses.length,
                    itemBuilder: (context, index) {
                      if (index < _searchedPersons.length) {
                        return Card(
                          child: ListTile(
                            title: Text(_searchedPersons[index].name),
                            subtitle: Text(
                              _searchedPersons[index].isPayed
                                  ? ''
                                  : 'Payment Expired',
                              style: const TextStyle(color: red),
                            ),
                            onTap: () async {
                              House? house = await getHouseByRoomName(
                                  _searchedPersons[index].roomName);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => PersonDetails(
                                          houseKey: house!.key,
                                          personName:
                                              _searchedPersons[index].name,
                                          roomName:
                                              _searchedPersons[index].roomName,
                                          index: index)));
                            },
                          ),
                        );
                      } else {
                        int houseIndex = index - _searchedPersons.length;
                        int bedspace = findBedSpaceAvailablebyHouse(
                            _searchedHouses[houseIndex]);
                        return Card(
                          child: ListTile(
                            title: Text(_searchedHouses[houseIndex].houseName),
                            subtitle: Text(
                              ' $bedspace BedSpace Available',
                              style: const TextStyle(color: red),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => HouseHomePage(
                                          houseKey:
                                              _searchedHouses[houseIndex].key,
                                          houseName: _searchedHouses[houseIndex]
                                              .houseName,
                                          ownerName: _searchedHouses[houseIndex]
                                              .ownerName)));
                            },
                          ),
                        );
                      }
                    },
                  ),
      ),
    );
  }

  void _searchData(String query) {
    List<Person> persons = [];
    List<House> houses = [];

    for (var house in houseList.value) {
      for (var floor in house.roomCount) {
        for (var room in floor) {
          for (var person in room.persons) {
            if (person.name.toLowerCase().contains(query.toLowerCase())) {
              persons.add(person);
            }
          }
        }
      }
    }

    houses.addAll(houseList.value.where((house) =>
        house.houseName.toLowerCase().contains(query.toLowerCase())));

    setState(() {
      _searchedPersons = persons;
      _searchedHouses = houses;
    });
  }
}
