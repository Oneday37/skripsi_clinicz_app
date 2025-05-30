import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_clinicz_app/screens/opening_section/splash_screen.dart';

void main() {
  runApp(CliniczApp());
}

class CliniczApp extends StatelessWidget {
  const CliniczApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: SplashScreen(),
    );
  }
}
