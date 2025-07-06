import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/opening_section/signup_page.dart';
import 'package:skripsi_clinicz_app/services/authentication_services.dart';
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
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  // METHOD FOR VALIDATION
  void validationForm() async {
    if (!formKey.currentState!.validate()) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: LottieBuilder.asset("assets/lottie_loading_animation.json"),
        );
      },
    );

    final authService = AuthenticationServices();
    final success = await authService.loginUser(
      usernameController.text.trim(),
      passwordController.text.trim(),
    );

    if (context.mounted) {
      Get.back();
    }

    if (success) {
      if (context.mounted) {
        Get.to(CustomNavBar());
      }
    } else {
      setState(() {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Column(
                children: [
                  Text("Login Failed !", style: AppFonts().titleFont),
                  SizedBox(height: 5),
                  LottieBuilder.asset(
                    height: MediaQuery.of(context).size.width / 6,
                    width: MediaQuery.of(context).size.width / 6,
                    "assets/lottie_failed_animation.json",
                    repeat: true,
                  ),
                ],
              ),
              content: Text(
                "Data yang anda masukan tidak sesuai. Harap memasukkan username dan password sesuai dengan yang anda daftarkan",
                style: AppFonts().normalBlackFont,
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args['successMessage'] != null) {
      Future.delayed(Duration.zero, () {
        Get.snackbar(
          "Berhasil",
          args['successMessage'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      });
    }
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
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
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
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style: AppFonts().greetingFontOutside2,
                            ),
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
                                validationForm();
                              },
                            ),
                          ],
                        ),
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
                                style: TextStyle(color: AppColors.primaryColor),
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
