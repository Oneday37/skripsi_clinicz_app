import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ci.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/screens/history_prediction_section/history_prediction_page.dart';
import 'package:skripsi_clinicz_app/screens/home_page.dart';
import 'package:skripsi_clinicz_app/screens/profile_page.dart';
import 'package:skripsi_clinicz_app/screens/settings_page.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int selectedPage = 0;
  List bodyPage = [
    HomePage(),
    HistoryPredictionPage(),
    ProfilePage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: bodyPage[selectedPage],
      bottomNavigationBar: StylishBottomBar(
        backgroundColor: AppColors.bgColor,
        currentIndex: selectedPage,
        option: AnimatedBarOptions(
          iconSize: 35,
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        items: [
          BottomBarItem(
            icon:
                selectedPage == 0
                    ? Iconify(Mdi.home, color: Colors.black)
                    : Iconify(Mdi.home_outline, color: AppColors.primaryColor),
            title: Text(
              "Home",
              style:
                  selectedPage == 0
                      ? GoogleFonts.robotoCondensed(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )
                      : GoogleFonts.robotoCondensed(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
            ),
          ),
          BottomBarItem(
            unSelectedColor: Colors.black,
            icon:
                selectedPage == 1
                    ? Iconify(Mdi.clipboard_text_history, color: Colors.black)
                    : Iconify(
                      Mdi.clipboard_text_history_outline,
                      color: AppColors.primaryColor,
                    ),
            title: Text(
              "Riwayat",
              style:
                  selectedPage == 1
                      ? GoogleFonts.robotoCondensed(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )
                      : GoogleFonts.robotoCondensed(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
            ),
          ),
          BottomBarItem(
            icon:
                selectedPage == 2
                    ? Iconify(Ic.person, color: Colors.black)
                    : Iconify(Ic.person_outline, color: AppColors.primaryColor),
            title: Text(
              "Profil",
              style:
                  selectedPage == 2
                      ? GoogleFonts.robotoCondensed(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )
                      : GoogleFonts.robotoCondensed(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
            ),
          ),
          BottomBarItem(
            icon:
                selectedPage == 3
                    ? Iconify(Ci.settings_filled, color: Colors.black)
                    : Iconify(Ci.settings, color: AppColors.primaryColor),
            title: Text(
              "Pengaturan",
              style:
                  selectedPage == 3
                      ? GoogleFonts.robotoCondensed(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )
                      : GoogleFonts.robotoCondensed(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
