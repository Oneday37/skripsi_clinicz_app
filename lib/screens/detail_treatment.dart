import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/widgets/custom_detail_drug.dart';

class DetailTreatment extends StatefulWidget {
  const DetailTreatment({super.key});

  @override
  State<DetailTreatment> createState() => _DetailTreatmentState();
}

class _DetailTreatmentState extends State<DetailTreatment> {
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

        // NAME OF DISEASE
        title: Text(
          "Bodrex Migra",
          style: TextStyle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // CONTAINER FOR IMAGE
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                "assets/clinicz_logo_2.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // DESCRIPTION OF TREATMENT
            CustomDetailDrug(
              label: "Deskripsi Obat:",
              content:
                  "Bodrex migra merupakan obat kaplet yang mengandung paracetamol, propyphenazone, dan kafein yang dapat digunakan untuk meringankan sakit kepala. Kandungan dari obat ini juga dapat digunakan untuk meredakan sakit ringan hingga sedang hingga menurunkan demam. Obat ini akan bekerja pada pusat pengontrol suhu tubuh di bagian otak dan mengurangi produksi prostaglandin, sehingga dapat menurunkan suhu tubuh saat demam dan meredakan nyeri. Obat ini dapat dibeli pada apotek-apotek terdekat. Namun, obat ini masih belum diproduksi secara teerbatas",
            ),
            SizedBox(height: 20),

            // MEDICINE INGREDIENTS
            CustomDetailDrug(
              label: "Kandungan:",
              content:
                  "Paracetamol 350 mg, Propyphenazone 150 mg, dan Kafein 50 mg",
            ),
            SizedBox(height: 20),

            // TREATMENT DOSAGE
            CustomDetailDrug(
              label: "Dosis Penggunaan:",
              content: "Dewasa: 1 kaplet, 3x sehari",
            ),
            SizedBox(height: 20),

            // TERMS OF USE
            CustomDetailDrug(
              label: "Aturan Pakai:",
              content: "Dapat dikonsumsi sesudah makan",
            ),
            SizedBox(height: 50),

            Text(
              "Obat yang serupa",
              style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),

            // LIST OF DRUG RECOMMENDATION
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Padding(
                      padding:
                          index == 3
                              ? EdgeInsets.all(0)
                              : EdgeInsets.only(right: 20),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 250,
                        decoration: BoxDecoration(
                          color: AppColors.thirdColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/clinicz_logo_2.png",
                                  fit: BoxFit.cover,
                                  scale: 5,
                                ),
                                // SizedBox(width: 10),
                                Text("Paracetamol"),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Paracetamol atau dapat dikenal sebagai asetaminofen merupakan obat yang dapat digunakan untuk meringankan berbagai penyakit, seperti sakit kepala, migrain, sakit gigi, sakit nyeri pada punggung, radang sendi, dan menurunkan demam. paracetamol bekerja pada pusat pengatur suhu pada bagian hipotalamus untuk menurunkan suhu tubuh (antipiretik) pada pasien dan menghambat sintesis prostaglandin sehingga dapat mengurangi nyeri ringan hingga sedang.",
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      print("Anda menekan rekomendasi obet ke-$index");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
