import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';

class CustomMainFeaturesIcon extends StatelessWidget {
  final dynamic featureIcon;
  final String featureName;
  final dynamic directPage;
  const CustomMainFeaturesIcon({
    super.key,
    required this.featureIcon,
    required this.featureName,
    required this.directPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 6,
            width: MediaQuery.of(context).size.width / 6,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: featureIcon,
            ),
          ),
          SizedBox(height: 10),
          Text(featureName, style: AppFonts().normalBlackFont),
        ],
      ),
      onTap: () {
        Get.to(directPage);
      },
    );
  }
}
