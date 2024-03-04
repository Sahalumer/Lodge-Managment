import 'package:flutter/material.dart';
import 'package:project/components/components.dart';
import 'package:project/functions/show_errors.dart';
import 'package:project/model/house_model.dart';

class Payment_dues extends StatefulWidget {
  House? house;
  List<House>? houses;
  Payment_dues({super.key, this.house, this.houses});

  @override
  State<Payment_dues> createState() => _Payment_duesState();
}

class _Payment_duesState extends State<Payment_dues> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignValue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary.color,
        centerTitle: true,
        foregroundColor: AppColor.white.color,
        toolbarHeight: 65,
        title: Text("Incompleted Payments"),
      ),
      body: ValueListenableBuilder(
          valueListenable: peymentdues,
          builder: (BuildContext context, List<Person> list, Widget? child) {
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(list[index].name),
                    ),
                  );
                });
          }),
    ));
  }

  assignValue() {
    if (widget.house != null) {
      getIncompletedPaymentBysingleHouse(widget.house!);
    } else if (widget.houses != null) {
      getIncompletedPaymentByHouses(widget.houses!);
    }
  }
}
