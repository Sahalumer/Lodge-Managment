// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/databaseconnection/person_functions.dart';
import 'package:project/model/house_model.dart';
import 'package:project/rooms/functions/funaction_rooms.dart';
import 'package:project/rooms/screens/see_details.dart';
import 'package:project/rooms/screens/update_payment.dart';
import 'package:project/rooms/widgets/elevated_button.dart';
import 'package:project/rooms/widgets/show_in_row.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/my_appbar.dart';
import 'package:project/widgets/scaffold_msg.dart';

class PersonDetails extends StatefulWidget {
  final int houseKey;
  final String personName;
  final String roomName;
  final int index;
  const PersonDetails(
      {super.key,
      required this.houseKey,
      required this.personName,
      required this.roomName,
      required this.index});

  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  late Future<Person?> _personFuture;

  @override
  void initState() {
    super.initState();
    _personFuture = loadPerson();
  }

  Future<Person?> loadPerson() async {
    return getPersonByName(widget.houseKey, widget.roomName, widget.personName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          onPressed: () {
            deleteFuncInRoom(
              context,
              () async {
                await deletePersonAsync(
                    widget.houseKey, widget.roomName, widget.index);
                Navigator.pop(context);
                Navigator.pop(context);
                showScaffoldMsg(context, "Deleted Succussfully");
              },
            );
          },
          title: "Client",
          iconData: Icons.delete,
        ),
        body: FutureBuilder<Person?>(
          future: _personFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              Person person = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: primary,
                      width: MediaQuery.of(context).size.width * .9,
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 65,
                            backgroundImage:
                                AssetImage('Assets/Image/users.png'),
                          ),
                          const SizedBox(height: 20),
                          ShowInRowInRoom(
                            label: "Name : ",
                            value: person.name,
                          ),
                          const SizedBox(height: 5),
                          ShowInRowInRoom(
                              label: "Phone Number : ",
                              value: person.phoneNumber.toString()),
                          const SizedBox(height: 15),
                          ElevatedButtonInRoom(
                            onPressed: () {
                              updatePayment(
                                context,
                                person,
                                widget.houseKey,
                                widget.roomName,
                              );
                            },
                          ),
                          const SizedBox(height: 5.1),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => SeeDetails(
                                    person: person,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'See Details>>',
                              style: TextStyle(color: white),
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: person.isPayed ? false : true,
                      child: const Text(
                        "Payment Expired... Update It! ",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('No data'),
              );
            }
          },
        ),
      ),
    );
  }
}
