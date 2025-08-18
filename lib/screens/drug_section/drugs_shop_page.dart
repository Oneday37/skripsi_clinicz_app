import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/data/drug_by_category_data.dart';
import 'package:skripsi_clinicz_app/models/shop_model/online_all_shop_model.dart';
import 'package:skripsi_clinicz_app/models/shop_model/online_category_shop_model.dart';
import 'package:skripsi_clinicz_app/screens/drug_section/drug_detail_shop_page.dart';
import 'package:skripsi_clinicz_app/services/online_shop_services.dart';

class DrugShopPage extends StatefulWidget {
  const DrugShopPage({super.key});

  @override
  State<DrugShopPage> createState() => _DrugShopPageState();
}

class _DrugShopPageState extends State<DrugShopPage> {
  String selectedCategory = 'All';
  late Future<List<dynamic>> futureDrugs;

  @override
  void initState() {
    super.initState();
    futureDrugs = OnlineShopServices().getAllDrugsShop();
  }

  void fetchDrugsByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        futureDrugs = OnlineShopServices().getAllDrugsShop();
      } else {
        futureDrugs = OnlineShopServices().getDrugsByCategoryShop(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("DiagnoCare Shop", style: AppFonts().normalGreetingFontInside),
            Image.asset(
              height: MediaQuery.of(context).size.width / 5,
              color: AppColors.primaryColor,
              "assets/diagnocare_logo2.png",
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              "Cari obat kamu berdasarkan kategori penyakit",
              style: AppFonts().subTitleFont,
            ),
            const SizedBox(height: 20),

            // DRUG CATEGORY
            SizedBox(
              height: MediaQuery.of(context).size.width / 10,
              child: ListView.builder(
                itemCount: drugsByCategory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final getDrugCategory = drugsByCategory[index];
                  final isSelected =
                      selectedCategory == getDrugCategory.drugCategory;
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColors.primaryColor
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        child: Center(
                          child: Text(
                            getDrugCategory.displayDrugName,
                            style:
                                isSelected
                                    ? AppFonts().normalWhiteBoldFont
                                    : AppFonts().normalBlackBoldFont,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      fetchDrugsByCategory(getDrugCategory.drugCategory);
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // LIST OF DRUGS
            FutureBuilder(
              future: futureDrugs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset(
                            "assets/lottie_search_data_loading.json",
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Sedang mengambil data ...",
                            style: AppFonts().titleFont,
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Data obat tidak tersedia."));
                } else {
                  final getDataDrugs = snapshot.data!;
                  getDataDrugs.sort((a, b) => a.namaObat.compareTo(b.namaObat));
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: getDataDrugs.length,
                    itemBuilder: (_, index) {
                      final getSingleDataDrug = getDataDrugs[index];
                      final drugName =
                          selectedCategory == 'All'
                              ? (getSingleDataDrug as OnlineShopModel).namaObat
                              : (getSingleDataDrug as OnlineShopByCategoryModel)
                                  .namaObat;
                      final drugImage =
                          selectedCategory == 'All'
                              ? (getSingleDataDrug as OnlineShopModel)
                                  .gambarObat
                              : (getSingleDataDrug as OnlineShopByCategoryModel)
                                  .gambarObat;
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 4 / 3,
                                  child: Image.network(drugImage),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: Text(
                                  drugName,
                                  style: AppFonts().normalBlackBoldFont,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          "Detail",
                                          style: AppFonts().normalWhiteBoldFont,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Get.to(
                                    DrugDetailShopPage(drugName: drugName),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Get.to(DrugDetailShopPage(drugName: drugName));
                        },
                      );
                    },
                  );
                }
              },
            ),
            Container(height: MediaQuery.of(context).size.width / 20),
          ],
        ),
      ),
    );
  }
}
