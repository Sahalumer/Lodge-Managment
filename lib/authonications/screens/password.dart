// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/authonications/widgets/text_field.dart';
import 'package:project/databaseconnection/Admin_Entry_db.dart';
import 'package:project/authonications/models/admin_model.dart';
import 'package:project/authonications/screens/reset_password.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/scaffold_msg.dart';

class ForgotPassord extends StatelessWidget {
  ForgotPassord({
    super.key,
  });
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 90,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    '''Forgot
Your Password?''',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Image.asset(
                'Assets/Image/forgot Password.png',
                height: 250,
              ),
              const SizedBox(
                height: 50,
              ),
              TextFieldInAuhtonications(
                  text: 'Email',
                  controller: emailcontroller,
                  hintText: 'Email',
                  keyboard: TextInputType.emailAddress),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white),
                  onPressed: () {
                    _inNextButton(context);
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                child: const Text(
                  "Back To Sign-In",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _inNextButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = emailcontroller.text.trim();

      AdminEntry? foundAdmin = await getAdminByEmail(email);

      if (foundAdmin != null && foundAdmin.email == email) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => ResetPassWord(
                      name: foundAdmin.name,
                    )));
      } else {
        showScaffoldMsg(context, "Invalid Email Address");
      }
    }
  }
}
