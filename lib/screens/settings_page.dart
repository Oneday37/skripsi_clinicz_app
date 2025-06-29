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
import 'package:skripsi_clinicz_app/widgets/custom_field_settings.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    void logoutHandle() async {
      print("Menekan Tombol");

      // Tampilkan animasi loading (gunakan Lottie)
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      try {
        print("Menekan Tombol1");

        final result = await AuthenticationServices().logoutUser();

        Get.back(); // Tutup loading
        Get.snackbar("Logout", result.message);
        Get.offAll(() => LoginPage()); // Pindah ke halaman login
      } catch (e) {
        Get.back(); // Tutup loading meskipun gagal
        Get.snackbar("Error", e.toString());
      }
    }

    void handleDeleteAccount() async {
      // Tampilkan loading
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      try {
        final result = await AuthenticationServices().deleteAccount();

        // Tutup loading
        Get.back();

        if (result) {
          // Navigasi & snackbar sukses
          Get.offAll(() => LoginPage());
          Get.snackbar("Berhasil", "Akun berhasil dihapus");
        }
      } catch (e) {
        Get.back();

        Get.snackbar("Error", e.toString());
      }
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
                print("Anda Menekan Button Ganti Password");
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
                    Get.back(); // Tutup dialog
                    handleDeleteAccount(); // Lanjut hapus akun
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
                  Get.to(LoginPage());
                  // logoutHandle();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
