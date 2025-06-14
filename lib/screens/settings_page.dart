import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ci.dart';
import 'package:iconify_flutter_plus/icons/line_md.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/opening_section/login_page.dart';
import 'package:skripsi_clinicz_app/widgets/custom_field_settings.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                print("Anda Menekan Button Ganti Password");
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
                print("Anda Menekan Button Tentang Kami");
              },
            ),
            SizedBox(height: 20),

            // CONTAINER FOR CONTACT US
            CustomFieldSettings(
              prefixIcon: Icon(Icons.contact_phone),
              label: "Hubungi Kami",
              onTap: () {
                print("Anda Menekan Button Hubungi Kami");
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
