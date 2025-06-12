import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';

class CustomMainFeaturesIcon extends StatelessWidget {
  dynamic featureIcon;
  String featureName;
  dynamic directPage;
  CustomMainFeaturesIcon({
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
            height: MediaQuery.of(context).size.width / 5.5,
            width: MediaQuery.of(context).size.width / 5.5,
            decoration: BoxDecoration(
              color: AppColors.fourthColor,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: featureIcon,
            ),
          ),
          SizedBox(height: 5),
          Text(featureName),
        ],
      ),
      onTap: () {
        Get.to(directPage);
      },
    );
  }
}
