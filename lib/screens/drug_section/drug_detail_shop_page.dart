import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/la.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/models/shop_model/online_single_shop_model.dart';
import 'package:skripsi_clinicz_app/services/online_shop_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_detail_drug.dart';
import 'package:url_launcher/url_launcher.dart';

class DrugDetailPage extends StatefulWidget {
  final String drugName;
  const DrugDetailPage({super.key, required this.drugName});

  @override
  State<DrugDetailPage> createState() => _DrugDetailPageState();
}

class _DrugDetailPageState extends State<DrugDetailPage> {
  String getLogoAssetFromStoreName(String storeName) {
    String fileName = storeName.toLowerCase().replaceAll(' ', '');
    return 'assets/${fileName}_logo.png';
  }

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
                LottieBuilder.asset("assets/lottie_search_data_loading.json"),
                Text("Sedang mengambil data...", style: AppFonts().titleFont),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        } else {
          final getSingleDataDrug = snapshot.data as OnlineSingleDrugModel;
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: AppBar(
              backgroundColor: AppColors.bgColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),

              // NAME OF DISEASE
              title: Text(getSingleDataDrug.nama, style: AppFonts().titleFont),
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
                  SizedBox(height: 50),

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

                    // ONLINE SHOP SECTION
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.bgColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10),

                                // FIRST DRUG STORE
                                ...getSingleDataDrug.linkStoreSatu.map((store) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: GestureDetector(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Container(
                                              height:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width /
                                                  7,
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width /
                                                  7,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Image.asset(
                                                getLogoAssetFromStoreName(
                                                  store.toko,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                store.toko,
                                                style:
                                                    AppFonts()
                                                        .normalBlackBoldFont,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        launchUrl(Uri.parse(store.url));
                                      },
                                    ),
                                  );
                                }),

                                Divider(color: Colors.black),

                                // SECOND DRUG STORE
                                ...getSingleDataDrug.linkStoreDua.map<Widget>((
                                  store,
                                ) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: GestureDetector(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Container(
                                              height:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width /
                                                  7,
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width /
                                                  7,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Image.asset(
                                                getLogoAssetFromStoreName(
                                                  store.toko,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                store.toko,
                                                style:
                                                    AppFonts()
                                                        .normalBlackBoldFont,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        launchUrl(Uri.parse(store.url));
                                      },
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        },
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
