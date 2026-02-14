// ignore_for_file: deprecated_member_use, prefer_const_constructors


import 'package:bxliv_media/app_routes.dart';
import 'package:bxliv_media/band_apply_form.dart';
import 'package:bxliv_media/navbar.dart';

import 'package:bxliv_media/packges.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class BandsScreen extends StatefulWidget {
  const BandsScreen({super.key});

  @override
  State<BandsScreen> createState() => _BandsScreenState();
}

class _BandsScreenState extends State<BandsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 50 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _scaffoldKey,
      drawer: buildMobileDrawer(context),
      body: Stack(
        
        children: [
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
              _buildHeroSection(context),
          
              _buildValuesSection(context),
              PackagesSection(),
           GetInTouchSection(),

                buildFooter(context),
              ],
            ),
          ),
          // Navbar overlay
            BXLIVNavBar(
            scrollController: _scrollController,
            isScrolled: _isScrolled,
            currentRoute: AppRoutes.home,
            onMenuPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          )
        ],
      ),
    );
  }
  
Widget _buildHeroSection(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final isMobile = size.width < 800;

 return Container(
  width: size.width,
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFBE8F3),
        Color(0xFFE8F9F7),
      ],
    ),
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 20 : 80,
      vertical: isMobile ? 40 : 40,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 120),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'PARTNER WITH ',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 42 : 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.1, // Adjusted for the gap between STORY and BXLIV
                ),
              ),
              TextSpan(
                text: 'US', // Removed the \n here
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 42 : 72,
                  fontWeight: FontWeight.bold,
               color: AppColors.accentCyan2,
                  height: 1.0, // Tightens the bottom of the text block
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // No SizedBox here
        Text(
           " Launch campaigns that move culture and drive results on TikTok.",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 14 : 18,
            color: Colors.grey[700],
            height: 1.2, // Reduced height to bring it even closer
          ),
        ),
        const SizedBox(height: 20),
      ],
    ),
  ),
);
}

 

Widget _buildValuesSection(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 800;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 20 : 70,
      vertical: isMobile ? 60 : 100,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: const [
          Color(0xFFFBE8F3), // Light pink (left)
          Color(0xFFE8F9F7), // Light cyan (right)
        ],
      ),
    ),
    child: Column(
      children: [
        // Title
       
        // Values grid
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = isMobile ? 1 : 4;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 1.3 : 1.3,
              children: [
                _valueCard(
              icon: Icons.center_focus_strong_rounded,  
                  title: 'Authentic Reach',
                  description:
                      'Connect with Gen Z through creators they trust.',
                  bgColor: const Color(0xFFFBE8F3),
                ),
                _valueCard(
                 icon: Icons.group_rounded,
                  title: '500+ Creators',
                  description:
                      'Access to our diverse roster of verified creators.',
                 bgColor: const Color(0xFFFBE8F3),
                ),
                _valueCard(
                 icon: Icons.bar_chart_rounded,
                  title: 'Proven ROI',
                  description:
                      'Data-driven campaigns that deliver measurable results.',
                  bgColor: const Color(0xFFFBE8F3),
                ),
                 _valueCard(
                 icon: Icons.bolt_rounded,
                  title: 'Fast Execution',
                  description:
                      'From brief to live campaign in as little as 2 weeks.',
                 bgColor: const Color(0xFFFBE8F3),
                ),
              
              
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget _valueCard({
  required IconData icon,
  required String title,
  required String description,
  required Color bgColor,
}) {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.grey[300]!,
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
           color: AppColors.accentCyan2.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.accentCyan2,
            size: 28,
          ),
        ),
        const SizedBox(height: 16),
        // Title
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        // Description
        Expanded(
          child: Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

}