import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ci.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/screens/opening_section/login_page.dart';
import 'package:skripsi_clinicz_app/widgets/custom_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        automaticallyImplyLeading: false,
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: Iconify(Ci.log_out, size: 30),
              onTap: () {
                Get.to(LoginPage());
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            //
            CircleAvatar(
              radius: 100,
              child: Image.asset(
                "assets/clinicz_logo_2.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 30),

            // CONTAINER FOR USERNAME
            CustomProfile(label: "Username:", content: "Muhammad Ridho"),
            SizedBox(height: 20),

            // CONTAINER FOR E-MAIL
            CustomProfile(
              label: "E - mail:",
              content: "ridhosan_bebanhok@gmail.com",
            ),
            SizedBox(height: 20),

            // CONTAINER FOR BIRTH OF DATE
            CustomProfile(label: "Tanggal Lahir:", content: "12 Desember 2012"),
          ],
        ),
      ),
    );
  }
}
