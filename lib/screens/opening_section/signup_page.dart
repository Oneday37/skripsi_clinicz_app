import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_outside.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_input.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_input_pass.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  String? selectedItem;
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text("Sign Up", style: TextStyle(fontSize: 40)),
                      ),

                      // CONTAINER FOR INPUT USERNAME
                      CustomFieldInput(
                        fieldIcon: const Icon(Icons.account_circle_outlined),
                        inputController: usernameController,
                        hintText: "Username",
                      ),
                      const SizedBox(height: 20),

                      // CONTAINER FOR INPUT E-MAIL
                      CustomFieldInput(
                        fieldIcon: const Icon(Icons.email_outlined),
                        inputController: emailController, // Ganti controller
                        hintText: "E-mail",
                      ),
                      const SizedBox(height: 20),

                      // CONTAINER FOR INPUT DATE OF BIRTH
                      CustomFieldInput(
                        fieldIcon: const Icon(Icons.calendar_month_outlined),
                        inputController: dateOfBirthController,
                        hintText: "TANGGAL / BULAN / TAHUN",
                      ),

                      const SizedBox(height: 20),

                      // CONTAINER FOR INPUT GENDER
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedItem,
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(15),
                            dropdownColor: AppColors.bgColor,
                            icon: const Icon(Icons.arrow_drop_down),
                            hint: const Row(
                              children: [
                                Icon(Icons.wc, color: Colors.grey),
                                SizedBox(width: 10),
                                Text(
                                  "Pilih Jenis Kelamin",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "Laki-laki",
                                child: Text("Laki-laki"),
                              ),
                              DropdownMenuItem(
                                value: "Perempuan",
                                child: Text("Perempuan"),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedItem = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // CONTAINER FOR INPUT PASSWORD
                      CustomFieldInputPass(
                        inputController: passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(height: 20),

                      // CONTAINER FOR CONFIRM PASSWORD
                      CustomFieldInputPass(
                        inputController: confirmPasswordController,
                        hintText: "Confirm Password",
                      ),
                      const SizedBox(height: 50),

                      // BUTTON FOR SIGN UP
                      CustomButtonOutside(
                        label: "Sign Up",
                        onTap: () {
                          print("Anda menekan tombol Sign Up");
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
    );
  }
}
