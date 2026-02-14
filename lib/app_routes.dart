import 'package:bxliv_media/bands.dart';
import 'package:bxliv_media/case_study.dart';
import 'package:bxliv_media/creators.dart';
import 'package:bxliv_media/dashbord.dart';
import 'package:bxliv_media/screens/about.dart';
import 'package:bxliv_media/screens/about_us.dart';
import 'package:bxliv_media/screens/admin_login.dart';
import 'package:bxliv_media/screens/code_of_conduct.dart';
import 'package:bxliv_media/screens/home_screen.dart';
import 'package:bxliv_media/screens/services.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
    static const String aboutus = '/aboutus';
  static const String services = '/services';

  static const String forCreators = '/for-creators';
  static const String forBrands = '/for-brands';
  static const String codeOfConduct = '/code-of-conduct';
  static const String login = '/login';
    static const String caseStudies = '/caseStudies';
        static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    about: (context) => const AboutScreen(),
    aboutus:(context) => const AboutUsPage(),
    services: (context) => const ServicesScreen(),
    caseStudies: (context) => const CaseStudy(),
    forCreators: (context) => const CreatorsScreen(),
    forBrands: (context) => const BandsScreen(),
    codeOfConduct: (context) => const CodeOfConductPage(),
    login: (context) => const LoginPage(),
 
    dashboard:(context) => const AdminDashboard(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(
        builder: builder,
        settings: settings,
      );
    }
    return null;
  }
}





