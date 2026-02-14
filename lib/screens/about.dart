// ignore_for_file: deprecated_member_use, prefer_const_constructors


import 'package:bxliv_media/app_routes.dart';
import 'package:bxliv_media/navbar.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
              _buildAboutSection(context),
              _buildValuesSection(context),
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
                text: 'STORY\n',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 42 : 72,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentMagenta,
                  height: 1.1, // Adjusted for the gap between STORY and BXLIV
                ),
              ),
              TextSpan(
                text: 'BXLIV Media', // Removed the \n here
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 42 : 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.0, // Tightens the bottom of the text block
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // No SizedBox here
        Text(
          'We started with a simple mission: help creators build careers and help brands connect authentically with audiences.',
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

 
Widget _buildAboutSection(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 800;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 20 : 240,
      vertical: isMobile ? 60 : 100,
    ),
    color: const Color(0xFFFBE8F3), // Light pink background
    child: isMobile
        ? Column(
            children: [
              // Title
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'BORN FROM ',
                      style: GoogleFonts.inter(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'PASSION',
                      style: GoogleFonts.inter(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF26d9d0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Description text
              Text(
                'B X LIV was founded in 2021 by creators, for creators. We saw the gap between talent and opportunity in the TikTok space and set out to bridge it.\n\nToday, we\'re one of the leading TikTok-focused agencies, managing over 500 creators and partnering with 150+ global brands.\n\nOur approach is different: we don\'t just manage creators, we invest in their long-term success. We don\'t just run campaigns, we create cultural moments.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 30),
              // Image with badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/5.jpg',
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                   bottom: -15,
                      right: -15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentMagenta,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '2021',
                            style: GoogleFonts.inter(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Founded',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'BORN FROM ',
                            style: GoogleFonts.inter(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'PASSION',
                            style: GoogleFonts.inter(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF26d9d0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Description text
                    Text(
                      'B X LIV was founded in 2021 by creators, for creators. We saw the gap between talent and opportunity in the TikTok space and set out to bridge it.\n\nToday, we\'re one of the leading TikTok-focused agencies, managing over 500 creators and partnering with 150+ global brands.\n\nOur approach is different: we don\'t just manage creators, we invest in their long-term success. We don\'t just run campaigns, we create cultural moments.',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                child: Stack(
                clipBehavior: Clip.none, 
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/5.jpg',
                        width: double.infinity,
                        height: 450,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      right: -15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentMagenta,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '2021',
                              style: GoogleFonts.inter(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Founded',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'OUR ',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 36 : 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'VALUES',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 36 : 56,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentMagenta,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Subtitle
        SizedBox(
          width: 600,
          child: Text(
            'BXLIV Media acts as a professional bridge between TikTok and creators, committed to building a safe, compliant, and sustainable digital entertainment ecosystem.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 14 : 16,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 40 : 60),
        // Values grid
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = isMobile ? 1 : 3;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 1.2 : 1.6,
              children: [
                _valueCard(
                  icon: Icons.people_rounded,
                  title: 'Creator-First',
                  description:
                      'We are committed to supporting and empowering creators to achieve sustainable growth, while respecting their creative independence and building long-term career paths on TikTok.',
                  bgColor: const Color(0xFFFBE8F3),
                ),
                _valueCard(
                  icon: Icons.shield_rounded,
                  title: 'Policy Compliance',
                  description:
                      'We fully comply with TikTok\'s policies and guidelines, including LIVE streaming rules, content standards, professional conduct, and community safety.',
                  bgColor: Colors.white,
                ),
                _valueCard(
                  icon: Icons.health_and_safety_rounded,
                  title: 'Safety & Well-Being',
                  description:
                      'We provide a safe and responsible digital working environment that protects creators from harmful practices, abuse, or exploitation.',
                  bgColor: Colors.white,
                ),
                _valueCard(
                  icon: Icons.trending_up_rounded,
                  title: 'Performance-Driven Growth',
                  description:
                      'We rely on data and analytics to optimize performance, increase engagement, and maximize monetization opportunities exclusively through TikTok\'s official tools.',
                  bgColor: const Color(0xFFE8F9F7),
                ),
                _valueCard(
                  icon: Icons.verified_user_rounded,
                  title: 'Transparency & Trust',
                  description:
                      'We ensure full transparency in operational processes, revenue models, and communication with creators and partners, with no undisclosed practices.',
                  bgColor: const Color(0xFFFBE8F3),
                ),
                _valueCard(
                  icon: Icons.school_rounded,
                  title: 'Creator Development',
                  description:
                      'We deliver continuous training covering LIVE streaming best practices, algorithm understanding, and professional standards.',
                  bgColor: Colors.white,
                ),
                _valueCard(
                  icon: Icons.auto_awesome_rounded,
                  title: 'Content Quality & Responsibility',
                  description:
                      'We are committed to promoting original, high-quality, and TikTok-compliant content that delivers real value to audiences.',
                  bgColor: Colors.white,
                ),
                _valueCard(
                  icon: Icons.gavel_rounded,
                  title: 'Professional & Legal Operations',
                  description:
                      'We operate as a UK-registered entertainment agency and adhere to international legal and regulatory standards across all our operations.',
                  bgColor: const Color(0xFFE8F9F7),
                ),
                _valueCard(
                  icon: Icons.public_rounded,
                  title: 'Diversity & Global Reach',
                  description:
                      'We support creators from diverse backgrounds and markets, respecting cultural differences and local operations within a global vision.',
                  bgColor: const Color(0xFFFBE8F3),
                ),
                _valueCard(
                  icon: Icons.lightbulb_rounded,
                  title: 'Innovation & Adaptability',
                  description:
                      'We continuously adapt to platform evolution and update our strategies in line with TikTok\'s product updates and market demands.',
                  bgColor: Colors.white,
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
            color: AppColors.accentMagenta.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.accentMagenta,
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