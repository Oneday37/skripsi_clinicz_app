import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skripsi_clinicz_app/constants/colors.dart';

class AppFonts {
  // OUTSIDE FONTS
  final greetingFontOutside = GoogleFonts.oswald(
    color: Colors.white,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  final greetingFontOutside2 = GoogleFonts.oswald(
    color: Colors.black,
    fontSize: 40,
    fontWeight: FontWeight.normal,
  );

  final normalGreetingFontOutside = GoogleFonts.oswald(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.normal,
  );

  // INSIDE FONTS
  final greetingFontInside = GoogleFonts.oswald(
    color: Colors.black,
    fontSize: 50,
    fontWeight: FontWeight.bold,
  );

  final normalGreetingFontInside = GoogleFonts.oswald(
    color: Colors.black,
    fontSize: 25,
    fontWeight: FontWeight.normal,
  );

  final titleFont = GoogleFonts.robotoCondensed(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  final subTitleFont = GoogleFonts.robotoCondensed(
    color: Colors.black,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  final normalBlackFont = GoogleFonts.robotoCondensed(
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  final normalBlackBoldFont = GoogleFonts.robotoCondensed(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  final normalBlackTagFont = GoogleFonts.robotoCondensed(
    color: Colors.black,
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );

  final normalWhiteFont = GoogleFonts.robotoCondensed(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.normal,
  );

  final normalWhiteBoldFont = GoogleFonts.robotoCondensed(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  final normalWhiteTagFont = GoogleFonts.robotoCondensed(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );

  final normalBlueFont = GoogleFonts.robotoCondensed(
    color: AppColors.primaryColor,
    fontSize: 17,
    fontWeight: FontWeight.normal,
  );

  final normalBlueBoldFont = GoogleFonts.robotoCondensed(
    color: AppColors.primaryColor,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  // INPUT FONT
  final inputFieldFont = GoogleFonts.robotoCondensed(
    color: Colors.grey,
    fontWeight: FontWeight.normal,
  );

  // ARTICLE FONTS
  final baseArticleTitleFont = GoogleFonts.robotoCondensed(
    color: Colors.black,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  // ALERT FONTS
  final normalRedFont = GoogleFonts.robotoCondensed(
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );

  final normalGreenFont = GoogleFonts.robotoCondensed(
    color: Colors.green,
    fontWeight: FontWeight.bold,
  );
}
