import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:iconify_flutter_plus/icons/ci.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/screens/home_page.dart';
import 'package:skripsi_clinicz_app/screens/prediction_section/prediction_disease_page.dart';
import 'package:skripsi_clinicz_app/screens/profile_page.dart';
import 'package:skripsi_clinicz_app/screens/settings_page.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int selectedPage = 0;
  List bodyPage = [
    HomePage(),
    PredictionDiseasePage(),
    ProfilePage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: bodyPage[selectedPage],
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: AppColors.thirdColor,
        selectedIndex: selectedPage,
        items: [
          FlashyTabBarItem(
            activeColor: AppColors.primaryColor,
            icon: Iconify(Mdi.home_outline, color: AppColors.primaryColor),
            title: Text("Home"),
          ),
          FlashyTabBarItem(
            activeColor: AppColors.primaryColor,
            icon: Iconify(
              Mdi.clipboard_text_history_outline,
              color: AppColors.primaryColor,
            ),
            title: Text("Prediction"),
          ),
          FlashyTabBarItem(
            activeColor: AppColors.primaryColor,
            icon: Iconify(Bi.person_fill, color: AppColors.primaryColor),
            title: Text("Profile"),
          ),
          FlashyTabBarItem(
            activeColor: AppColors.primaryColor,
            icon: Iconify(Ci.settings, color: AppColors.primaryColor),
            title: Text("Settings"),
          ),
        ],
        onItemSelected: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
