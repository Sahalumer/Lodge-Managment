// screens/auth/create_account.dart

import 'package:flutter/material.dart';
import 'package:project/authonications/models/admin_model.dart';
import 'package:project/authonications/screens/login_page.dart';
import 'package:project/authonications/widgets/text_field.dart';
import 'package:project/databaseconnection/Admin_Entry_db.dart';
import 'package:project/privacy_terms/terms_and_privacy/text.dart';
import 'package:project/widgets/custom_elavatedbutton.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getAllAdmins();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 37, 40, 23),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('Assets/Image/create ac.webp'),
                Container(
                  height: screenHeight * 0.715,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17)),
                    color: Color.fromARGB(255, 1, 33, 90),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Create Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldInAuhtonications(
                            text: "User Name",
                            controller: nameController,
                            hintText: 'Enter User Name',
                            keyboard: TextInputType.name),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFieldInAuhtonications(
                            text: "Email",
                            controller: emailController,
                            hintText: "Enter The Email",
                            keyboard: TextInputType.emailAddress),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFieldInAuhtonications(
                            text: "Password",
                            controller: passwordController,
                            hintText: "Enter The Password",
                            keyboard: TextInputType.text),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomElevatedButton(
                          buttonText: "Create Account",
                          onPressed: () => _inSignUpButton(context),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already Have An Account? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              child: const Text(
                                'Sign_In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => LoginPage(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        const TermsOfUse()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _inSignUpButton(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final admin = AdminEntry(name: name, email: email, password: password);
      addAdmin(admin);
      Navigator.pop(context);
    }
  }
}
