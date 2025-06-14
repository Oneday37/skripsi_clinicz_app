import 'package:flutter/material.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
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
        title: Text("Profile", style: AppFonts().titleFont),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // PHOTO PROFILE
            Center(
              child: Container(
                height: MediaQuery.of(context).size.width / 2.5,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(130),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image.asset(
                    "assets/dummy_profile.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),

            // CONTAINER FOR USERNAME
            CustomProfile(label: "Username", content: "Muhammad Ridho"),
            SizedBox(height: 20),

            // CONTAINER FOR E-MAIL
            CustomProfile(
              label: "E-mail",
              content: "ridhosan_bebanhok@gmail.com",
            ),
            SizedBox(height: 20),

            // CONTAINER FOR GENDER
            CustomProfile(label: "Jenis Kelamin", content: "Laki-Laki"),
            SizedBox(height: 20),

            // CONTAINER FOR BIRTH OF DATE
            CustomProfile(label: "Tanggal Lahir", content: "12 Desember 2012"),
          ],
        ),
      ),
    );
  }
}
