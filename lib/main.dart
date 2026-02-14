import 'package:bxliv_media/app_routes.dart';
import 'package:bxliv_media/translaltion.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration.zero);
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAkpbMx3Y5DDIPZl-iJm8sGOl4r5Y-eNek',
          appId: '1:787889189326:android:afc89e2a9438a93e003b9f',
          messagingSenderId: '787889189326',
          projectId: 'bxliv-f7403',
          storageBucket: "bxliv-f7403.firebasestorage.app"));
  runApp(const MyApp());
}

// Exact colors from the website
class AppColors {
  static const primaryPink = Color(0xFFEC4899);  // Main brand pink
  static const accentCyan = Color(0xFF06B6D4);   // Cyan accent
  static const darkPurple = Color(0xFF2D1B3D);   // Dark purple for gradient
  static const darkTeal = Color(0xFF0D3D3D);     // Dark teal for gradient
  static const textWhite = Color(0xFFFFFFFF);
  static const textGray = Color.fromARGB(255, 71, 74, 78);
  static const bgLight = Color(0xFFF3F4F6);
//static const accentMagenta = Color(0xFFFF1493);
static const Color accentMagenta = Color(0xFFE82063); 
static const Color accentCyan2 = Color(0xFF26d9d0);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: MyTranslations(),
     // locale: const Locale('ar'),
      title: 'BXLIV Media',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Inter',
        textTheme: GoogleFonts.interTextTheme(),
      ),
      // Use named routes
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      // OR use Router (recommended for more control)
      // home: const CreatorsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}