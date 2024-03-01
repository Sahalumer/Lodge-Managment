import 'package:flutter/material.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/model/house_model.dart';

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
                        return ListTile(
                          title:
                              Text('Person: ${_searchedPersons[index].name}'),
                          subtitle:
                              Text('Room: ${_searchedPersons[index].roomName}'),
                        );
                      } else {
                        int houseIndex = index - _searchedPersons.length;
                        return ListTile(
                          title: Text(
                              'House: ${_searchedHouses[houseIndex].houseName}'),
                          subtitle: Text(
                              'Owner: ${_searchedHouses[houseIndex].ownerName}'),
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

    // Search for persons
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

    // Search for houses
    houses.addAll(houseList.value.where((house) =>
        house.houseName.toLowerCase().contains(query.toLowerCase())));

    setState(() {
      _searchedPersons = persons;
      _searchedHouses = houses;
    });
  }
}
