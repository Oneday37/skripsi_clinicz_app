import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/services/authentication_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_outside.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_input.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_input_pass.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  String? selectedItem;
  String hintTanggal = "Tanggal / Bulan / Tahun";
  late DateTime dateNow;

  // Fungsi untuk memilih tanggal
  Future<void> selectDate() async {
    try {
      dateNow = DateFormat("d MMMM yyyy", "id_ID").parse(hintTanggal);
    } catch (_) {
      dateNow = DateTime.now();
    }

    DateTime? setDate = await showDatePicker(
      context: context,
      locale: const Locale("id", "ID"),
      initialDate: dateNow,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    if (setDate != null) {
      setState(() {
        hintTanggal = DateFormat("d MMMM yyyy", "id_ID").format(setDate);
      });
    }
  }

  // Fungsi untuk mendaftarkan user
  Future<void> registerUser() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        hintTanggal == "Tanggal / Bulan / Tahun" ||
        selectedItem == null) {
      Get.snackbar(
        "Peringatan",
        "Semua data harus diisi.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Peringatan",
        "Password dan konfirmasi tidak cocok.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    DateTime? tanggalFormatted;
    try {
      tanggalFormatted = DateFormat("d MMMM yyyy", "id_ID").parse(hintTanggal);
    } catch (e) {
      Get.snackbar(
        "Kesalahan",
        "Format tanggal tidak valid.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Center(
            child: Lottie.network(
              "https://lottie.host/0560e367-edb5-4b1f-b168-ba3d78612933/pVsiTOmBTd.json",
            ),
          ),
    );

    try {
      final response = await AuthenticationServices().registerAccount(
        usernameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        selectedItem!,
        tanggalFormatted,
      );

      if (context.mounted) Get.back(); // tutup dialog loading

      if (response == "exists") {
        Get.snackbar(
          "Gagal",
          "Email sudah digunakan.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (response == "success") {
        Get.snackbar(
          "Berhasil",
          "Akun berhasil dibuat.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back(); // Kembali ke halaman sebelumnya (login)
      } else {
        Get.snackbar(
          "Gagal",
          "Terjadi kesalahan saat mendaftar.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      if (context.mounted) Get.back();
      Get.snackbar(
        "Error",
        "Terjadi kesalahan: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateOfBirthController.dispose();
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_back),
                              const SizedBox(width: 10),
                              Text(
                                "Back to login",
                                style: AppFonts().normalBlackFont,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Sign Up",
                            style: AppFonts().greetingFontOutside2,
                          ),
                        ),

                        CustomFieldInput(
                          fieldIcon: const Icon(Icons.account_circle_outlined),
                          inputController: usernameController,
                          hintText: "Username",
                        ),
                        const SizedBox(height: 20),

                        CustomFieldInput(
                          fieldIcon: const Icon(Icons.email_outlined),
                          inputController: emailController,
                          hintText: "E-mail",
                        ),
                        const SizedBox(height: 20),

                        // Date of Birth Picker
                        TextFormField(
                          controller: dateOfBirthController,
                          readOnly: true,
                          onTap: selectDate,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.calendar_month_outlined,
                            ),
                            hintText: hintTanggal,
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
                        const SizedBox(height: 20),

                        // Gender dropdown
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
                                  value: "male",
                                  child: Text("male"),
                                ),
                                DropdownMenuItem(
                                  value: "female",
                                  child: Text("female"),
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

                        CustomFieldInputPass(
                          inputController: passwordController,
                          hintText: "Password",
                        ),
                        const SizedBox(height: 20),

                        CustomFieldInputPass(
                          inputController: confirmPasswordController,
                          hintText: "Confirm Password",
                        ),
                        const SizedBox(height: 50),

                        CustomButtonOutside(
                          label: "Sign Up",
                          onTap: () => registerUser(),
                        ),
                      ],
                    ),
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
