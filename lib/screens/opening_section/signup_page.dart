import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/opening_section/login_page.dart';
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
  final TextEditingController imageProfileController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  File? imageProfile;
  String? selectedItem;
  String hintTanggal = "Tanggal / Bulan / Tahun";
  late DateTime dateNow;
  late String tanggalFormattedToJson;
  bool loadingToSendData = false;

  // FUNCTION TO PICK DATE
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

  // FUNCTION FOR PICK IMAGE IN GALLERY
  Future getProfileImage(ImageSource profileImage) async {
    final getImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (getImage != null) {
      setState(() {
        imageProfile = File(getImage.path);
      });
    }
  }

  // FUNCTION FOR REGISTER USER
  Future<void> registerUser() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        hintTanggal == "Tanggal / Bulan / Tahun" ||
        imageProfile == null ||
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
        "Password dan konfirmasi password tidak cocok.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      final parsedDate = DateFormat("d MMMM yyyy", "id_ID").parse(hintTanggal);
      tanggalFormattedToJson = DateFormat("yyyy-MM-dd").format(parsedDate);
    } catch (e) {
      Get.snackbar(
        "Kesalahan",
        "Format tanggal tidak valid.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => loadingToSendData = true);

    try {
      final response = await AuthenticationServices().registerAccount(
        usernameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        selectedItem!,
        tanggalFormattedToJson,
        imageProfile!,
      );

      final message = response['message']?.toString().toLowerCase() ?? "";

      if (message.contains("already exists")) {
        Get.snackbar(
          "Gagal",
          "Username atau email sudah digunakan.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (message.contains("success")) {
        Get.offAll(
          () => LoginPage(),
          arguments: {"successMessage": "Akun berhasil dibuat."},
        );
      } else {
        Get.snackbar(
          "Gagal",
          response['message'] ?? "Terjadi kesalahan saat mendaftar.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() => loadingToSendData = false);
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateOfBirthController.dispose();
    imageProfileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        color: AppColors.primaryColor,
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

                        // DATE OF BIRTH
                        TextFormField(
                          controller: dateOfBirthController,
                          readOnly: true,
                          onTap: selectDate,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.calendar_month_outlined,
                            ),
                            prefixIconColor: AppColors.iconColor,
                            hintText: hintTanggal,
                            hintStyle:
                                hintTanggal == "Tanggal / Bulan / Tahun"
                                    ? TextStyle(color: AppColors.iconColor)
                                    : TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.iconColor,
                                // width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // GENDER DROPDOWN
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
                                  child: Text("Male"),
                                ),
                                DropdownMenuItem(
                                  value: "female",
                                  child: Text("Female"),
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

                        // AREA FOR PICK IMAGE PROFILE
                        TextFormField(
                          controller: imageProfileController,
                          readOnly: true,
                          onTap: () async {
                            await getProfileImage(ImageSource.gallery);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.image),
                            prefixIconColor: AppColors.iconColor,
                            hintText:
                                imageProfile == null
                                    ? "Ambil Foto Anda di Gallery"
                                    : "Foto Profile.jpg",
                            hintStyle:
                                imageProfile == null
                                    ? TextStyle(color: AppColors.iconColor)
                                    : TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.iconColor,
                                // width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
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

                        loadingToSendData
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButtonOutside(
                              label: "Sign Up",
                              onTap: () {
                                registerUser();
                              },
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
