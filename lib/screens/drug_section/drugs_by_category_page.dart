import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drug_detail_shop_page.dart';
import 'package:skripsi_clinicz_app/services/online_shop_services.dart';

class DrugsByCategoryPage extends StatefulWidget {
  final String displayDrugName;
  final String drugCategory;
  const DrugsByCategoryPage({
    super.key,
    required this.displayDrugName,
    required this.drugCategory,
  });

  @override
  State<DrugsByCategoryPage> createState() => _DrugsByCategoryPageState();
}

class _DrugsByCategoryPageState extends State<DrugsByCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: OnlineShopServices().getDrugsByCategoryShop(widget.drugCategory),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset("assets/lottie_search_data_loading.json"),
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
          final getDataDrug = snapshot.data;
          getDataDrug!.sort((a, b) => a.nama.compareTo(b.nama));
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
              title: Text(widget.displayDrugName, style: AppFonts().titleFont),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: getDataDrug.length,
                itemBuilder: (_, index) {
                  final getSingleData = getDataDrug[index];
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: Image.network(
                                  getSingleData.gambar,
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                getSingleData.nama,
                                style: AppFonts().normalWhiteBoldFont,
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.to(DrugDetailPage(drugName: getSingleData.nama));
                    },
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
