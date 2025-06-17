import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/opening_section/signup_page.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_outside.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_input.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_input_pass.dart';
import 'package:skripsi_clinicz_app/widgets/custom_navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.thirdColor,
      appBar: AppBar(
        backgroundColor: AppColors.thirdColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello!", style: AppFonts().greetingFontOutside),
                Text(
                  "Selamat Datang di DiagnoCare",
                  style: AppFonts().normalGreetingFontOutside,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),

          // CONTAINER FOR INPUT NAME ACCOUNT & PASSWORD
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Login", style: AppFonts().greetingFontOutside2),
                          const SizedBox(height: 30),

                          // CONTAINER FOR INPUT USERNAME
                          CustomFieldInput(
                            fieldIcon: const Icon(
                              Icons.account_circle_outlined,
                            ),
                            inputController: usernameController,
                            hintText: "Username",
                          ),
                          const SizedBox(height: 20),

                          // CONTAINER FOR INPUT PASSWORD
                          CustomFieldInputPass(
                            inputController: passwordController,
                            hintText: "Password",
                          ),
                          const SizedBox(height: 50),

                          // BUTTON FOR LOGIN
                          CustomButtonOutside(
                            label: "Login",
                            onTap: () {
                              Get.to(CustomNavBar());
                            },
                          ),
                        ],
                      ),

                      // CONTAINER FOR SING UP
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have any account? ",
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(color: AppColors.thirdColor),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(SignUpPage());
                                      },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
