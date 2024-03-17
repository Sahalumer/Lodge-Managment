// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:project/authonications/widgets/password_textfield.dart';
import 'package:project/databaseconnection/Admin_Entry_db.dart';
import 'package:project/authonications/models/admin_model.dart';
import 'package:project/authonications/screens/login_page.dart';
import 'package:project/widgets/colors.dart';

class ResetPassWord extends StatelessWidget {
  final String name;

  ResetPassWord({super.key, required this.name});
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('Assets/Image/LogoImage.png'),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.key_outlined, color: Colors.white, size: 25),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Reset Your Password',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 65,
                ),
                PasswordTextField(
                    hintText: 'Password', controller: passwordController),
                const SizedBox(
                  height: 10,
                ),
                PasswordTextField(
                  hintText: "Re-Password",
                  controller: rePasswordController,
                  password: passwordController.text,
                ),
                const SizedBox(
                  height: 45,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(250, 53),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _onResetPasswordButton(context);
                  },
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onResetPasswordButton(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final newPassword = passwordController.text;
      final foundAdmin = await getAdminByName(name);

      if (foundAdmin != null) {
        final updatedAdmin = AdminEntry(
            name: foundAdmin.name,
            email: foundAdmin.email,
            password: newPassword);

        updateAdmin(foundAdmin.key, updatedAdmin);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => LoginPage()),
          (route) => false,
        );
      }
    }
  }
}
