// ignore_for_file: deprecated_member_use, prefer_const_constructors


import 'package:bxliv_media/app_routes.dart';
import 'package:bxliv_media/navbar.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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
           _buildDetailedServicesSection(context),
            _buildHowWeWorkSection(context),
            _buildReadyToStartSection(context),
              Container(
          height: 1,
          color: Colors.grey[300],
        ),
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
                text: 'OUR ',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 42 : 72,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentMagenta,
                  height: 1.1, // Adjusted for the gap between STORY and BXLIV
                ),
              ),
              TextSpan(
                text: 'SERVICES', // Removed the \n here
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
          'Comprehensive solutions for creators looking to grow and brands looking to connect.',
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

Widget _buildHowWeWorkSection(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 800;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 90 : 150,
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
                text: 'HOW WE ',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 36 : 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'WORK',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 36 : 56,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF26d9d0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Subtitle
        Text(
          'Our proven process for delivering results.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 16 : 18,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: isMobile ? 40 : 60),
        // Process steps
        if (isMobile)
          Column(
            children: [
              _processStep(
                number: '01',
                title: 'Discovery',
                description: 'We learn about your goals and challenges',
              ),
              const SizedBox(height: 32),
              _processStep(
                number: '02',
                title: 'Strategy',
                description: 'We develop a customized plan for success',
              ),
              const SizedBox(height: 32),
              _processStep(
                number: '03',
                title: 'Execution',
                description: 'We implement with precision and creativity',
              ),
              const SizedBox(height: 32),
              _processStep(
                number: '04',
                title: 'Optimize',
                description: 'We analyze results and continuously improve',
              ),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _processStep(
                  number: '01',
                  title: 'Discovery',
                  description: 'We learn about your goals and challenges',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey[400],
                  size: 28,
                ),
              ),
              Expanded(
                child: _processStep(
                  number: '02',
                  title: 'Strategy',
                  description: 'We develop a customized plan for success',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey[400],
                  size: 28,
                ),
              ),
              Expanded(
                child: _processStep(
                  number: '03',
                  title: 'Execution',
                  description: 'We implement with precision and creativity',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey[400],
                  size: 28,
                ),
              ),
              Expanded(
                child: _processStep(
                  number: '04',
                  title: 'Optimize',
                  description: 'We analyze results and continuously improve',
                ),
              ),
            ],
          ),
      ],
    ),
  );
}

Widget _processStep({
  required String number,
  required String title,
  required String description,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Step number
      Text(
        number,
        style: GoogleFonts.inter(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          color: AppColors.accentMagenta.withOpacity(0.2),
          height: 0.9,
        ),
      ),
      const SizedBox(height: 8),
      // Step title
      Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 12),
      // Step description
      Text(
        description,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.grey[700],
          height: 1.6,
        ),
      ),
    ],
  );
}
Widget _buildDetailedServicesSection(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 800;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 20 : 200,
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
    child: LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = isMobile ? 1 : 2;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 32,
          mainAxisSpacing: 32,
          childAspectRatio: isMobile ? 1: 1.5,
          children: [
            _serviceDetailCard(
              icon: Icons.people,
              title: 'Creator Management',
              description:
                  'Full-service talent management for TikTok creators at every stage of their journey.',
              features: [
                'Brand deal negotiations',
                'Content strategy development',
                'Career planning & growth',
                'Legal & contract support',
                'Revenue optimization',
              ],
              bgColor: const Color(0xFFFBE8F3),
              iconColor: AppColors.accentMagenta,
            ),
            _serviceDetailCard(
              icon: Icons.campaign,
              title: 'Brand Marketing',
              description:
                  'Strategic influencer campaigns that drive awareness, engagement, and conversions.',
              features: [
                'Creator matching & vetting',
                'Campaign strategy & planning',
                'Performance tracking',
                'Authentic storytelling',
                'ROI optimization',
              ],
              bgColor: const Color(0xFFE8F9F7),
              iconColor: const Color(0xFF26d9d0),
            ),
            _serviceDetailCard(
              icon: Icons.videocam,
              title: 'Content Creation',
              description:
                  'Professional content production that captures attention and tells your story.',
              features: [
                'Concept development',
                'Video production',
                'Editing & post-production',
                'Trend-based content',
              ],
              bgColor: const Color(0xFFFBE8F3),
              iconColor: AppColors.accentMagenta,
            ),
            _serviceDetailCard(
              icon: Icons.sports_esports,
              title: 'Gaming Division',
              description:
                  'Specialized management and marketing for gaming creators and esports talent.',
              features: [
                'Gaming creator management',
                'Esports partnerships',
                'Stream optimization',
                'Gaming brand campaigns',
              ],
              bgColor: const Color(0xFFE8F9F7),
              iconColor: const Color(0xFF26d9d0),
            ),
              _serviceDetailCard(
              icon:  Icons.school_rounded,
              title: 'Creator Training',
              description:
                  'Comprehensive training programs to develop the next generation of TikTok stars.',
              features: [
                'Content creation workshops',
                'Algorithm mastery',
                'Monetization strategies',
                'Personal branding',
                'Community building'
              ],
              bgColor: const Color(0xFFFBE8F3),
              iconColor: AppColors.accentMagenta,),
                 _serviceDetailCard(
              icon: Icons.trending_up_rounded,
              title: 'Growth Strategy',
              description:
                  'Data-driven strategies to accelerate follower growth and engagement.',
              features: [
                'Profile optimization',
                'Posting schedule optimization',
                'Hashtag strategy',
                'Engagement tactics',
                'Analytics & reporting'
              ],
              bgColor: const Color(0xFFE8F9F7),
              iconColor: const Color(0xFF26d9d0),
            ),
          ],
        );
      },
    ),
  );
}

Widget _serviceDetailCard({
  required IconData icon,
  required String title,
  required String description,
  required List<String> features,
  required Color bgColor,
  required Color iconColor,
}) {
  return Container(
    padding: const EdgeInsets.all(32),
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
        // Icon with Title and Description in row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 32,
              ),
            ),
            const SizedBox(width: 20),
            // Title and Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Features list
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: iconColor,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildReadyToStartSection(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 800;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 20 : 450,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'READY TO ',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 36 : 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'START?',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 36 : 56,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentMagenta,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        // Subtitle
        Text(
          'Whether you\'re a creator or a brand, we\'d love to hear from you.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 16 : 17,
            color: Colors.grey[700],
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        // Buttons
        Wrap(
          spacing: 20,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            // Creator Button
            ElevatedButton(
              onPressed: () {
                  _navigateTo(context, AppRoutes.forCreators);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentMagenta,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'I\'m a Creator',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            // Brand Button
          OutlinedButton(
  onPressed: () {
      _navigateTo(context, AppRoutes.forBrands);
  },
  style: OutlinedButton.styleFrom(
    side: BorderSide(
      color: Colors.black.withOpacity(0.2),
      width: 1,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 40,
      vertical: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ).copyWith(
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return const Color(0xFF26d9d0); // Cyan on hover
        }
        return Colors.white; // Default transparent
      },
    ),
  ),
  child: Text(
    'I\'m a Brand',
    style: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
)
          ],
        ),
      ],
    ),
  );
}
  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}