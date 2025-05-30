import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/screens/detail_treatment.dart';

class MainTreatmentPage extends StatefulWidget {
  const MainTreatmentPage({super.key});

  @override
  State<MainTreatmentPage> createState() => _MainTreatmentPageState();
}

class _MainTreatmentPageState extends State<MainTreatmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.thirdColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Rekomendasi Pengobatan",
          style: TextStyle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      // CONTAINER OF PREDICTION RESULT
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.thirdColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAME OF DISEASE
                      Text(
                        "Bodrex Migra",
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),

                      // DESCRIPTION OF DISEASE
                      Text(
                        "Bodrex migra merupakan obat kaplet yang mengandung paracetamol, propyphenazone, dan kafein yang dapat digunakan untuk meringankan sakit kepala. Kandungan dari obat ini juga dapat digunakan untuk meredakan sakit ringan hingga sedang hingga menurunkan demam. Obat ini akan bekerja pada pusat pengontrol suhu tubuh di bagian otak dan mengurangi produksi prostaglandin, sehingga dapat menurunkan suhu tubuh saat demam dan meredakan nyeri. Obat ini dapat dibeli pada apotek-apotek terdekat. Namun, obat ini masih belum diproduksi secara teerbatas",
                        style: GoogleFonts.roboto(),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 50),

                      // ALERT MESSAGE !!!
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text: "Note: ",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "Untuk pemeriksaan lebih lanjut, diharapkan untuk menghubungi dokter",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            Get.to(DetailTreatment());
          },
        ),
      ),
    );
  }
}
