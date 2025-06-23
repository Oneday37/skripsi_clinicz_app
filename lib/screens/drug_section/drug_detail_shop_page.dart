import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/la.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/dummy_text.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/services/online_shop_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_detail_drug.dart';

class DrugDetailShopPage extends StatefulWidget {
  String drugName;
  DrugDetailShopPage({super.key, required this.drugName});

  @override
  State<DrugDetailShopPage> createState() => _DrugDetailShopPageState();
}

class _DrugDetailShopPageState extends State<DrugDetailShopPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnlineShopServices().getSingleDrusShop(widget.drugName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                  "https://lottie.host/0560e367-edb5-4b1f-b168-ba3d78612933/pVsiTOmBTd.json",
                ),
                Text("Sedang memuat data...", style: AppFonts().titleFont),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        } else {
          final getSingleDataDrug = snapshot.data;
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: AppBar(
              backgroundColor: AppColors.thirdColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),

              // NAME OF DISEASE
              title: Text(getSingleDataDrug!.nama, style: AppFonts().titleFont),
              centerTitle: true,
            ),

            body: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  // CONTAINER FOR IMAGE
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(getSingleDataDrug.gambar),
                  ),
                  SizedBox(height: 30),

                  // DESCRIPTION OF TREATMENT
                  CustomDetailDrug(
                    label: "Deskripsi Obat:",
                    content: getSingleDataDrug.deskripsi,
                  ),
                  SizedBox(height: 30),

                  // MEDICINE INGREDIENTS
                  CustomDetailDrug(
                    label: "Kandungan:",
                    content: getSingleDataDrug.kandungan,
                  ),
                  SizedBox(height: 30),

                  // TREATMENT DOSAGE
                  CustomDetailDrug(
                    label: "Dosis Penggunaan:",
                    content: getSingleDataDrug.dosis,
                  ),
                  SizedBox(height: 30),

                  // TERMS OF USE
                  CustomDetailDrug(
                    label: "Aturan Pakai:",
                    content: getSingleDataDrug.aturanPakai,
                  ),
                  SizedBox(height: 30),

                  // BUTTON FOR REDIRECT SHOP
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "Go To Market",
                                style: AppFonts().normalWhiteBoldFont,
                              ),
                            ),
                            Iconify(
                              La.shopping_cart,
                              size: 35,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      print(
                        "Anda menekan button Go To Market yang akan mengarahkan anda ke link toko online",
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
