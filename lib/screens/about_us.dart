// ignore_for_file: deprecated_member_use

import 'package:bxliv_media/app_routes.dart';
import 'package:bxliv_media/main.dart';
import 'package:bxliv_media/navbar.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
final ScrollController _scrollController = ScrollController();

  bool _isScrolled = false;

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
      
      body: Stack(
        children:[ SingleChildScrollView(
          child: Column(
            children: [
            
              _buildVisionMissionSection(context),
              _buildObjectivesSection(context),
              _buildCultureSection(context),
              buildFooter(context,)
            ],
          ),
        ),
           BXLIVNavBar(
               scrollController: _scrollController,
          isScrolled: _isScrolled,
          currentRoute: AppRoutes.about, 
           )
        ]
         
      ),
       
    );
  }

  // Navigation Bar
  
  // Hero Section
 
  // Vision and Mission Section
  Widget _buildVisionMissionSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 200,
        vertical: isMobile ? 60 : 100,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFBE8F3),
            Color(0xFFE8F9F7),
          ],
        ),
      ),
      child: isMobile
          ? Column(
              children: [
                _visionMissionCard(
                  icon: Icons.public_rounded,
                  title: 'Vision',
                  description:
                      'To become a leading global TikTok entertainment agency that empowers creators and LIVE streamers through a safe, professional, and sustainable ecosystem, transforming talent into brands and creativity into long-term income.',
                  iconColor: AppColors.accentMagenta,
                ),
                const SizedBox(height: 32),
                _visionMissionCard(
                  icon: Icons.tablet_rounded,
                  title: 'Mission',
                  description:
                      'To enable creators to reach their full potential on TikTok by providing a secure and compliant operating environment, delivering performance-driven growth strategies, offering continuous training and professional development, and ensuring transparent monetization models.',
                  iconColor: const Color(0xFF26d9d0),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _visionMissionCard(
                    icon: Icons.public_rounded,
                    title: 'Vision',
                    description:
                        'To become a leading global TikTok entertainment agency that empowers creators and LIVE streamers through a safe, professional, and sustainable ecosystem, transforming talent into brands and creativity into long-term income.',
                    iconColor: AppColors.accentMagenta,
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _visionMissionCard(
                    icon: Icons.tablet_rounded,
                    title: 'Mission',
                    description:
                        'To enable creators to reach their full potential on TikTok by providing a secure and compliant operating environment, delivering performance-driven growth strategies, offering continuous training and professional development, and ensuring transparent monetization models.',
                    iconColor: const Color(0xFF26d9d0),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _visionMissionCard({
    required IconData icon,
    required String title,
    required String description,
    required Color iconColor,
  }) {

      
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFBE8F3),
            Color(0xFFE8F9F7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 40),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  // Objectives Section
  Widget _buildObjectivesSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    final objectives = [
      {
        'icon': Icons.trending_up_rounded,
        'title': 'Creator Empowerment & Growth',
        'points': [
          'Support sustainable account growth and audience engagement',
          'Develop creators into trusted digital brands',
          'Build long-term career pathways for talent',
        ],
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.shield_rounded,
        'title': 'Compliance & Safety',
        'points': [
          'Maintain full compliance with TikTok policies',
          'Protect creator accounts and digital reputation',
          'Enforce clear Creator Code of Conduct',
        ],
        'color': const Color(0xFF26d9d0),
      },
      {
        'icon': Icons.bar_chart_rounded,
        'title': 'Performance & Monetization',
        'points': [
          'Optimize LIVE streaming and content performance',
          'Maximize revenue through TikTok official features',
          'Leverage data and analytics for improvement',
        ],
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.star_rounded,
        'title': 'Professional Entertainment Ecosystem',
        'points': [
          'Develop high-quality Gaming and LIVE creators',
          'Promote responsible and engaging content',
          'Encourage innovation aligned with standards',
        ],
        'color': const Color(0xFF26d9d0),
      },
      {
        'icon': Icons.public_rounded,
        'title': 'Sustainable Global Expansion',
        'points': [
          'Operate across multiple markets and cultures',
          'Build strategic partnerships',
          'Scale operations while maintaining quality',
        ],
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.verified_user_rounded,
        'title': 'Transparency & Trust',
        'points': [
          'Ensure clear communication and fair structures',
          'Build long-term relationships with creators',
          'Maintain transparent revenue models',
        ],
        'color': const Color(0xFF26d9d0),
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 100,
      ),
      decoration: const BoxDecoration(
         gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFBE8F3),
            Color(0xFFE8F9F7),
          ],
        ),
      ),
    //  color: Colors.white,
      child: Column(
        children: [
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
                  text: 'OBJECTIVES',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentMagenta,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isMobile ? 1 : 3;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.4,
                children: objectives
                    .map(
                      (obj) => _objectiveCard(
                        icon: obj['icon'] as IconData,
                        title: obj['title'] as String,
                        points: obj['points'] as List<String>,
                        color: obj['color'] as Color,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _objectiveCard({
    required IconData icon,
    required String title,
    required List<String> points,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: points
                  .map(
                    (point) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, right: 8),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              point,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.grey[700],
                                height: 1.5,
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

  // Culture Section
  Widget _buildCultureSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    final cultureValues = [
      {
        'icon': Icons.people_rounded,
        'title': 'Creator-Centric Culture',
        'description':
            'We foster a creator-first environment that respects creative individuality while supporting long-term professional development.',
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.shield_rounded,
        'title': 'Policy-Driven & Compliant',
        'description':
            'Compliance is embedded in our daily operations. We maintain strict alignment with TikTok Community Guidelines and monetization rules.',
        'color': const Color(0xFF26d9d0),
      },
      {
        'icon': Icons.health_and_safety_rounded,
        'title': 'Safety, Wellbeing & Responsibility',
        'description':
            'We promote a safe and respectful digital environment and prioritize the wellbeing of creators and audiences.',
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.star_rounded,
        'title': 'Performance with Integrity',
        'description':
            'We are results-oriented while maintaining integrity. Growth is achieved through authentic engagement and data-informed strategies.',
        'color': const Color(0xFF26d9d0),
      },
      {
        'icon': Icons.verified_user_rounded,
        'title': 'Professionalism & Accountability',
        'description':
            'We operate with clear structures, defined responsibilities, and transparent communication with high professional standards.',
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.school_rounded,
        'title': 'Learning & Continuous Improvement',
        'description':
            'TikTok evolves rapidly — and so do we. Our culture encourages continuous learning and adaptation to new features.',
        'color': const Color(0xFF26d9d0),
      },
      {
        'icon': Icons.handshake_rounded,
        'title': 'Collaboration & Mutual Respect',
        'description':
            'Strong partnerships are built on trust, respect, and shared objectives between creators, teams, and stakeholders.',
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.visibility_rounded,
        'title': 'Transparency & Trust',
        'description':
            'We value open communication. All processes and structures are communicated clearly and ethically.',
        'color': const Color(0xFF26d9d0),
      },
      {
        'icon': Icons.public_rounded,
        'title': 'Global Mindset, Local Sensitivity',
        'description':
            'As a UK-based agency with global reach, we respect cultural diversity while applying consistent ethical standards.',
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.trending_up_rounded,
        'title': 'Sustainable Creator Economy',
        'description':
            'Our culture supports long-term participation by focusing on stability, compliance, and professional growth.',
        'color': const Color(0xFF26d9d0),
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 150,
        vertical: isMobile ? 60 : 50,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFBE8F3),
            Color(0xFFE8F9F7),
          ],
        ),
      ),
      child: Column(
        children: [
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
                  text: 'CULTURE',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentMagenta,
                  ),
                ),
              ],
            ),
          ),
              SizedBox(height: isMobile ? 40 : 20),
          // Intro text
          SizedBox(
            width: 800,
            child: Text(
              'At BXLIVMedia, our culture is built around creator empowerment, platform integrity, and sustainable growth within the TikTok ecosystem. We operate with a deep understanding of TikTok\'s values, policies, and community standards.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: isMobile ? 14 : 16,
                color: Colors.grey[700],
                height: 1.8,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 40 : 40),
          // Title
       
        //  SizedBox(height: isMobile ? 40 : 60),
          // Culture values grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isMobile ? 1 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 28,
                mainAxisSpacing: 28,
                childAspectRatio: isMobile ? 1.2 : 2.5,
                children: cultureValues
                    .map(
                      (value) => _cultureValueCard(
                        icon: value['icon'] as IconData,
                        title: value['title'] as String,
                        description: value['description'] as String,
                        color: value['color'] as Color,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _cultureValueCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}