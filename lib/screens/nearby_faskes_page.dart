import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';
import 'package:skripsi_clinicz_app/constants/fonts.dart';
import 'package:skripsi_clinicz_app/models/nearby_faskes_model.dart';
import 'package:skripsi_clinicz_app/services/nearby_faskes_services.dart';
import 'package:skripsi_clinicz_app/widgets/custom_button_inside.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyFaskesPage extends StatefulWidget {
  const NearbyFaskesPage({super.key});

  @override
  State<NearbyFaskesPage> createState() => _NearbyFaskesPageState();
}

class _NearbyFaskesPageState extends State<NearbyFaskesPage> {
  List<NearbyClinicsModel>? clinics;
  bool isLoading = false;
  String? error;
  String? currentAddress;

  // METHOD FOR GET LOCATION
  Future<void> fetchNearbyClinics() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw "Layanan lokasi tidak aktif.";

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw "Izin lokasi ditolak.";
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw "Izin lokasi ditolak permanen.";
      }

      final position = await Geolocator.getCurrentPosition();

      // GET LATITUDE & LONGITUDE PLACE
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = placemarks.first;
      final fullAddress =
          "${place.street}, ${place.subLocality}, ${place.locality}";

      final data = await NearbyFaskesServices().getNearbyClinics(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      setState(() {
        clinics = data;
        currentAddress = fullAddress;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),

        // APPBAR AREA
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Faskes Sekitar", style: AppFonts().normalGreetingFontInside),
            const SizedBox(width: 20),

            // AREA FOR LOCATION
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.thirdColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(7),
                child: Row(
                  children: [
                    Iconify(
                      Mdi.hospital_marker,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        child: Text(
                          currentAddress ?? "Deteksi Lokasi Anda",
                          style: AppFonts().normalBlueFont,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: fetchNearbyClinics,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) {
          // FETCH LOCATION
          if (isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.network(
                    "https://lottie.host/866755c5-0a5b-46c1-b72b-8d6b7586c35e/RBTyU8u0EA.json",
                  ),
                  Text(
                    "Sedang menganalisa lokasi sekitar...",
                    style: AppFonts().titleFont,
                  ),
                ],
              ),
            );
          }
          // ERROR STATE
          else if (error != null) {
            return Center(child: Text("Terjadi kesalahan: $error"));
          }
          // FIRST CONDITION WHEN DATA IS NOT AVAILABLE
          else if (clinics == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: LottieBuilder.network(
                    "https://lottie.host/33c240ef-d43d-4ae9-bed2-221a8f3d74aa/32VMWwz7an.json",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: CustomButtonInside(
                    label: "Deteksi Lokasi Anda!",
                    onTap: fetchNearbyClinics,
                  ),
                ),
              ],
            );
          }
          // CONDITION WHEN DOES'NT HAVE NEARBY CLINIC
          else if (clinics!.isEmpty) {
            return Center(
              child: Text(
                "Tidak ada Fasilitas Kesehatan Terdekat",
                style: AppFonts().titleFont,
              ),
            );
          }
          // LIST OF CLINICS
          else {
            return ListView.builder(
              itemCount: clinics!.length,
              itemBuilder: (_, index) {
                final item = clinics![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
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
                          Text(item.name, style: AppFonts().subTitleFont),
                          const SizedBox(height: 10),
                          Text(
                            item.address,
                            style: AppFonts().normalBlackFont,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Jarak: ",
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "${item.distance.toStringAsFixed(2)} meter",
                                      style: GoogleFonts.robotoCondensed(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 100),
                              Expanded(
                                child: CustomButtonInside(
                                  label: "See On Maps",
                                  onTap: () {
                                    launchUrl(Uri.parse(item.mapLink));
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
            );
          }
        },
      ),
    );
  }
}
