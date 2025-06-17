import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:iconify_flutter_plus/icons/ci.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/screens/history_prediction_section/history_prediction_page.dart';
import 'package:skripsi_clinicz_app/screens/home_page.dart';
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
    HistoryPredictionPage(),
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
            activeColor: Colors.black,
            icon: Iconify(Mdi.home_outline, color: Colors.black),
            title: Text("Home"),
          ),
          FlashyTabBarItem(
            activeColor: Colors.black,
            icon: Iconify(
              Mdi.clipboard_text_history_outline,
              color: Colors.black,
            ),
            title: Text("History"),
          ),
          FlashyTabBarItem(
            activeColor: Colors.black,
            icon: Iconify(Bi.person_fill, color: Colors.black),
            title: Text("Profile"),
          ),
          FlashyTabBarItem(
            activeColor: Colors.black,
            icon: Iconify(Ci.settings, color: Colors.black),
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
