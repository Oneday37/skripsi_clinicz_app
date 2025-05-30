import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/screens/opening_section/signup_page.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_outside.dart';
import 'package:skripsi_clinicz_app/widgets/custom_navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visibilityButton = true;

  void visibilityPass() {
    setState(() {
      visibilityButton = !visibilityButton;
    });
  }

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
      appBar: AppBar(backgroundColor: AppColors.thirdColor),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CONTAINER WELCOME
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello!", style: TextStyle(fontSize: 40)),
                Text("Selamt Data di Clinicz", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          SizedBox(height: 50),

          // CONTAINER FOR INPUT NAME ACCOUNT & PASSWORD
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login", style: TextStyle(fontSize: 40)),
                    SizedBox(height: 30),

                    // CONTAINER FOR INPUT USERNAME
                    TextFormField(
                      controller: usernameController,
                      cursorColor: AppColors.thirdColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_outlined),
                        prefixIconColor: AppColors.iconColor,
                        hintText: "Username",
                        hintStyle: TextStyle(color: AppColors.iconColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.thirdColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // CONTAINER FOR INPUT PASSWORD
                    TextFormField(
                      controller: passwordController,
                      cursorColor: AppColors.thirdColor,
                      obscureText: visibilityButton == true ? true : false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        prefixIconColor: AppColors.iconColor,
                        hintText: "Password",
                        hintStyle: TextStyle(color: AppColors.iconColor),
                        suffixIcon: GestureDetector(
                          child:
                              visibilityButton == true
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                          onTap: () {
                            visibilityPass();
                          },
                        ),
                        suffixIconColor: AppColors.iconColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.thirdColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),

                    // BUTTON FOR LOGIN
                    CustomButtonOutside(
                      label: "Login",
                      onTap: () {
                        Get.to(CustomNavBar());
                      },
                    ),

                    // CONTAINER FOR SING UP
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have any account? ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Sing Up",
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
