// screens/auth/create_account.dart

import 'package:flutter/material.dart';
import 'package:project/authonications/models/admin_model.dart';
import 'package:project/authonications/screens/login_page.dart';
import 'package:project/databaseconnection/Admin_Entry_db.dart';
import 'package:project/privacy_terms/terms_and_privacy/text.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/widgets/custom_elavatedbutton.dart';
import 'package:project/widgets/custom_textfield.dart';
import 'package:project/widgets/validator.dart';

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
                  height: screenHeight * 0.67,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'User Name',
                                style: TextStyle(
                                  color: white,
                                ),
                              ),
                              CustomTextField(
                                controller: nameController,
                                hintText: "Enter User Name",
                                labelText: "",
                                keyboardType: TextInputType.name,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email',
                                style: TextStyle(
                                  color: white,
                                ),
                              ),
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 217, 217, 217),
                                    hintText: 'Enter The Email ',
                                    labelText: '',
                                    labelStyle: TextStyle(color: Colors.black)),
                                validator: Validators.emailValidator,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'PassWord',
                                style: TextStyle(
                                  color: white,
                                ),
                              ),
                              TextFormField(
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 217, 217, 217),
                                  hintText: 'Enter The PassWord',
                                  labelText: '',
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                validator: Validators.passwordValidator,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ],
                          ),
                        ),
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
