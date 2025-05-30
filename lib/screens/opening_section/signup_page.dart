import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool visibilityButton = true;
  bool visibilityConfirmPassButton = true;

  void visibilityPass() {
    setState(() {
      visibilityButton = !visibilityButton;
    });
  }

  void confirmVisibilityPass() {
    setState(() {
      visibilityConfirmPassButton = !visibilityConfirmPassButton;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.thirdColor,
      ),
      body: Container(
        color: AppColors.thirdColor,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.width / 7),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      GestureDetector(
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back),
                            SizedBox(width: 5),
                            Text("Back to login"),
                          ],
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text("Sign Up", style: TextStyle(fontSize: 40)),
                      ),

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
                      SizedBox(height: 30),

                      // CONTAINER FOR CONFIRM PASSWORD
                      TextFormField(
                        controller: confirmPasswordController,
                        cursorColor: AppColors.thirdColor,
                        obscureText:
                            visibilityConfirmPassButton == true ? true : false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          prefixIconColor: AppColors.iconColor,
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: AppColors.iconColor),
                          suffixIcon: GestureDetector(
                            child:
                                visibilityConfirmPassButton == true
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                            onTap: () {
                              confirmVisibilityPass();
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

                      // BUTTON FOR SIGN UP
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.thirdColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
      ),
    );
  }
}
