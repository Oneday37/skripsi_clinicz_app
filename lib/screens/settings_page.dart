import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ci.dart';
import 'package:iconify_flutter_plus/icons/line_md.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/about_us_page.dart';
import 'package:skripsi_clinicz_app/screens/contact_us_page.dart';
import 'package:skripsi_clinicz_app/screens/opening_section/login_page.dart';
import 'package:skripsi_clinicz_app/services/authentication_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_input_pass.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_settings.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // HANDLER UPDATE PASSWORD
    void showChangePasswordDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Ubah Password"),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomFieldInputPass(
                    inputController: currentPassController,
                    hintText: "Password Lama",
                  ),

                  const SizedBox(height: 10),
                  CustomFieldInputPass(
                    inputController: newPassController,
                    hintText: "Password Baru",
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Batal"),
                onPressed: () => Get.back(),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() => isLoading = true);
                    try {
                      AuthenticationServices().updatePassword(
                        currentPassController.text,
                        newPassController.text,
                      );
                      if (context.mounted) {
                        Get.offAll(
                          () => LoginPage(),
                          arguments: {
                            "successMessage":
                                "Password berhasil diubah, silakan login kembali.",
                          },
                        );
                      }
                    } catch (e) {
                      setState(() => isLoading = false);
                      Get.snackbar(
                        "Gagal",
                        "Gagal mengubah password: $e",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  }
                },
                child: const Text("Ubah"),
              ),
            ],
          );
        },
      ).then((_) {
        currentPassController.clear();
        newPassController.clear();
      });
    }

    // HANDLER DELETE ACCOUNT
    void handleDeleteAccount() async {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      try {
        final result = await AuthenticationServices().deleteAccount();
        Get.back();
        if (result) {
          Get.offAll(() => LoginPage());
          Get.snackbar(
            "Berhasil",
            "Akun berhasil dihapus",
            backgroundColor: Colors.green,
          );
        }
      } catch (e) {
        Get.back();
        Get.snackbar("Error", e.toString());
      }
    }

    // HANDLER LOGOUT
    void logoutHandle() {
      Get.defaultDialog(
        title: "Logout Akun",
        titleStyle: AppFonts().titleFont,
        middleText: "Apakah anda ingin keluar dari akun",
        middleTextStyle: AppFonts().normalBlackFont,
        textConfirm: "Iya",
        onConfirm: () {
          AuthenticationServices().logoutUser();
          Get.back();
        },
        textCancel: "Tidak",
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        automaticallyImplyLeading: false,
        title: Text("Pengaturan", style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pengaturan Akun", style: AppFonts().subTitleFont),
            SizedBox(height: 10),

            // CONTAINER FOR CHANGE PASSWORD
            CustomFieldSettings(
              prefixIcon: Icon(Icons.key),
              label: "Ganti Password",
              onTap: () {
                showChangePasswordDialog();
              },
            ),
            SizedBox(height: 20),

            // CONTAINER FOR DELETE ACCOUNT
            CustomFieldSettings(
              prefixIcon: Iconify(LineMd.account_delete),
              label: "Hapus Akun Saya",
              onTap: () async {
                Get.defaultDialog(
                  title: "Konfirmasi",
                  middleText: "Yakin ingin menghapus akun secara permanen?",
                  textCancel: "Batal",
                  textConfirm: "Hapus",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.back();
                    handleDeleteAccount();
                  },
                );
              },
            ),
            SizedBox(height: 20),

            Text("Aplikasi DiagnoCare", style: AppFonts().subTitleFont),
            SizedBox(height: 10),

            // CONTAINER FOR ABOUT US
            CustomFieldSettings(
              prefixIcon: Icon(Icons.people),
              label: "Tentang Kami",
              onTap: () {
                Get.to(AboutUsPage());
              },
            ),
            SizedBox(height: 20),

            // CONTAINER FOR CONTACT US
            CustomFieldSettings(
              prefixIcon: Icon(Icons.contact_phone),
              label: "Hubungi Kami",
              onTap: () {
                Get.to(ContactUsPage());
              },
            ),

            SizedBox(height: 50),

            Center(
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Iconify(Ci.log_out, color: Colors.white),
                        SizedBox(width: 20),
                        Text("Logout", style: AppFonts().normalWhiteFont),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  logoutHandle();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
