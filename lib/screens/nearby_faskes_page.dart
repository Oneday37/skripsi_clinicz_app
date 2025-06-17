import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';

class NearbyFaskesPage extends StatefulWidget {
  const NearbyFaskesPage({super.key});

  @override
  State<NearbyFaskesPage> createState() => _NearbyFaskesPageState();
}

class _NearbyFaskesPageState extends State<NearbyFaskesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Faskes Sekitar", style: AppFonts().titleFont),
            SizedBox(width: 30),

            // AREA FOR LOCATION
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.thirdColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    children: [
                      Iconify(
                        Mdi.hospital_marker,
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Jl. Raya Susukan",
                          style: AppFonts().normalBlueFont,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.thirdColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("RS Citama", style: AppFonts().subTitleFont),
                    SizedBox(height: 10),
                    Text(
                      "Jalan Pabuaran No.52, Pabuaran, Kec. Bojong Gede, Bogor, Jawa Barat 16320",
                      style: AppFonts().normalBlackFont,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: "Jarak: ",
                            style: GoogleFonts.robotoCondensed(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "573.9 meter",
                                style: GoogleFonts.robotoCondensed(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 100),
                        Expanded(
                          child: CustomButtonInside(
                            label: "See On Maps",
                            onTap: () {
                              print("Anda Menekan Menu Peta ke-$index");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
