import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:iconify_flutter_plus/icons/carbon.dart';
import 'package:iconify_flutter_plus/icons/heroicons.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/screens/home_page.dart';
import 'package:skripsi_clinicz_app/screens/medicine_page.dart';
import 'package:skripsi_clinicz_app/screens/prediction_page.dart/prediction_disease_page.dart';
import 'package:skripsi_clinicz_app/screens/profile_page.dart';

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
    MedicinePage(),
    ProfilePage(),
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
            icon: Iconify(Heroicons.home_solid, color: AppColors.primaryColor),
            title: Text("Home"),
          ),
          FlashyTabBarItem(
            activeColor: AppColors.primaryColor,
            icon: Iconify(
              Carbon.reminder_medical,
              color: AppColors.primaryColor,
            ),
            title: Text("Prediction"),
          ),
          FlashyTabBarItem(
            activeColor: AppColors.primaryColor,
            icon: Iconify(Mdi.medicine_bottle, color: AppColors.primaryColor),
            title: Text("Medicine"),
          ),
          FlashyTabBarItem(
            activeColor: AppColors.primaryColor,
            icon: Iconify(Bi.person_fill, color: AppColors.primaryColor),
            title: Text("Profile"),
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
