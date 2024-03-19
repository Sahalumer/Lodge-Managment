// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project/databaseconnection/Admin_Entry_db.dart';
import 'package:project/databaseconnection/house_db.dart';
import 'package:project/authonications/models/admin_model.dart';
import 'package:project/authonications/screens/create_account.dart';
import 'package:project/authonications/screens/password.dart';
import 'package:project/home/screens/first_sign_in.dart';
import 'package:project/home/screens/home.dart';
import 'package:project/widgets/custom_elavatedbutton.dart';
import 'package:project/widgets/custom_textbutton.dart';
import 'package:project/widgets/custom_textfield.dart';
import 'package:project/widgets/scaffold_msg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool ispermission = false;

  @override
  Widget build(BuildContext context) {
    getAllAdmins();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 33, 90),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 95),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('Assets/Image/LogoImage.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CustomTextField(
                      labelText: "User Name",
                      hintText: "User Name",
                      controller: nameController,
                      keyboardType: null,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: CustomTextField(
                      labelText: "PassWord",
                      hintText: "PassWord",
                      controller: passwordController,
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomElevatedButton(
                    buttonText: "Sign-In",
                    onPressed: () => _inSignInButton(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextButton(
                          buttonText: "Create Account",
                          onPressed: () => _creatAccount(context),
                        ),
                        CustomTextButton(
                          buttonText: 'Forgot Password?',
                          onPressed: () => _forgotPassword(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _inSignInButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text.trim();
      final password = passwordController.text.trim();

      AdminEntry? foundAdmin = await getAdminByName(name);
      if (foundAdmin != null && foundAdmin.password == password) {
        final preferes = await SharedPreferences.getInstance();
        await preferes.setString('value', name);
        await getAllHousesByOwnerAsync(name);

        if (houseList.value.isEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => FirstSignIn(
                name: name,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => Home(
                name: name,
              ),
            ),
          );
        }
      } else {
        showScaffoldMsg(context, 'Invalid Username or PassWord');
      }
    }
  }

  _creatAccount(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateAccount(),
      ),
    );
  }

  _forgotPassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ForgotPassord(),
      ),
    );
  }
}
