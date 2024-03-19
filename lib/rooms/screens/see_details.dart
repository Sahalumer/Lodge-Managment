import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/model/house_model.dart';
import 'package:project/rooms/widgets/elevated_button.dart';
import 'package:project/rooms/widgets/show_in_row.dart';
import 'package:project/widgets/colors.dart';

class SeeDetails extends StatelessWidget {
  final Person person;
  const SeeDetails({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('Assets/Image/LogoImage.png'),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.710,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17)),
                    color: white,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                ShowInRowInDetails(
                                    label: "Name : ", value: person.name),
                                const SizedBox(
                                  height: 15,
                                ),
                                ShowInRowInDetails(
                                    label: "Contact : ",
                                    value: person.phoneNumber.toString()),
                                const SizedBox(
                                  height: 15,
                                ),
                                ShowInRowInDetails(
                                    label: "Join Date : ",
                                    value: person.joinDate),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  'Id Proof',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            FileImage(File(person.imagePath)),
                                        fit: BoxFit.cover),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ElevattedButtonInDetails(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
