import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppBar(
          backgroundColor: AppColors.bgColor,

          // APPLICATION LOGO
          leading: Image.asset("assets/clinicz_logo_2.png"),
          title: Row(
            children: [
              Text(
                "Clinicz",
                style: GoogleFonts.roboto(color: AppColors.primaryColor),
              ),
              SizedBox(width: 20),

              // SEARCH BAR FOR ARTICLE
              Expanded(
                child: TextFormField(
                  cursorColor: AppColors.primaryColor,
                  cursorHeight: 25,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.thirdColor,
                    prefixIcon: Icon(Icons.search, size: 25),
                    prefixIconColor: AppColors.primaryColor,

                    hintText: "Search article",
                    hintStyle: TextStyle(color: AppColors.primaryColor),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.thirdColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.thirdColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
