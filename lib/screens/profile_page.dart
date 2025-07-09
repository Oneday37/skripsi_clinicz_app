import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/services/authentication_services.dart';
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
      body: FutureBuilder(
        future: AuthenticationServices().getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset("assets/lottie_search_data_loading.json"),
                Text("Sedang memuat profile...", style: AppFonts().titleFont),
              ],
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Gagal memuat data profil'));
          } else {
            final getDataProfile = snapshot.data!;
            return Padding(
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
                        child: Image.network(
                          getDataProfile.profileImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              "https://pbs.twimg.com/profile_images/1321030814436655106/87OcbZNm_400x400.jpg",
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // CONTAINER FOR USERNAME
                  CustomProfile(
                    label: "Username",
                    content: getDataProfile.username,
                  ),
                  SizedBox(height: 20),

                  // CONTAINER FOR E-MAIL
                  CustomProfile(label: "E-mail", content: getDataProfile.email),
                  SizedBox(height: 20),

                  // CONTAINER FOR GENDER
                  CustomProfile(
                    label: "Jenis Kelamin",
                    content: getDataProfile.gender,
                  ),
                  SizedBox(height: 20),

                  // CONTAINER FOR BIRTH OF DATE
                  CustomProfile(
                    label: "Tanggal Lahir",
                    content: DateFormat(
                      "d MMMM yyyy",
                    ).format(getDataProfile.dateOfBirth),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
