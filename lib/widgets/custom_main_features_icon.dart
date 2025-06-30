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
              color: AppColors.thirdColor,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: featureIcon,
            ),
          ),
          SizedBox(height: 5),
          Text(featureName, style: AppFonts().normalBlackFont),
        ],
      ),
      onTap: () {
        Get.to(directPage);
      },
    );
  }
}
