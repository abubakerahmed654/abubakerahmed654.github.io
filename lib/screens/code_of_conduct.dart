// ignore_for_file: deprecated_member_use

import 'package:bxliv_media/app_routes.dart';
import 'package:bxliv_media/main.dart';
import 'package:bxliv_media/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeOfConductPage extends StatefulWidget {
  const CodeOfConductPage({super.key});

  @override
  State<CodeOfConductPage> createState() => _CodeOfConductPageState();
}



class _CodeOfConductPageState extends State<CodeOfConductPage> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildConductSection(context),
            _buildDisciplinarySection(context),
            _buildDeclarationSection(context),
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
      ),
    );
  }

  // Hero Section
  Widget _buildHeroSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 400,
        vertical: isMobile ? 50 : 80,
      ),
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.accentMagenta.withOpacity(0.15),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              'STANDARDS & EXPECTATIONS',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accentMagenta,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'CODE OF ',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 40 : 64,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'CONDUCT',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 40 : 64,
                    fontWeight: FontWeight.w900,
                    color: AppColors.accentMagenta,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 600,
            child: Text(
              'Professional standards and expectations for all creators in our community. Upholding these values ensures we maintain a safe, compliant, and thriving ecosystem.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: isMobile ? 15 : 18,
                color: Colors.grey[700],
                height: 1.7,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Conduct Items Section
  Widget _buildConductSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    final conductItems = [
      {
        'icon': Icons.shield_rounded,
        'title': 'TikTok Compliance',
        'description':
            'Fully comply with all TikTok policies, guidelines, Community Standards, LIVE rules, and monetization policies.',
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.people_rounded,
        'title': 'Professional Conduct',
        'description':
            'Maintain respect during streams and content creation. Avoid abuse, harassment, hate speech, and inappropriate language.',
        'color': const Color(0xFF26d9d0),
      },
      {
        'icon': Icons.health_and_safety_rounded,
        'title': 'Safe Content',
        'description':
            'Ensure all content is legal, compliant, free from violence, and suitable for various age groups per platform guidelines.',
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.verified_user_rounded,
        'title': 'Integrity & Transparency',
        'description':
            'Never manipulate metrics, use unauthorized tools, or exploit audiences. Disclose sponsored content transparently.',
        'color': const Color(0xFF26d9d0),
      },
      {
        'icon': Icons.security_rounded,
        'title': 'Account Security',
        'description':
            'Secure your account, don\'t share access, never sell/rent accounts. Report suspicious activity immediately.',
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.trending_up_rounded,
        'title': 'Official Monetization',
        'description':
            'Use only TikTok\'s official monetization tools. Prohibited: unofficial transactions, audience exploitation, unauthorized transfers.',
        'color': const Color(0xFF26d9d0),
      },
      {
        'icon': Icons.handshake_rounded,
        'title': 'Agency Commitment',
        'description':
            'Adhere to streaming schedules, maintain professional communication, and follow operational guidelines provided.',
        'color': AppColors.accentMagenta,
      },
      {
        'icon': Icons.star_rounded,
        'title': 'Reputation Protection',
        'description':
            'Refrain from actions that harm TikTok\'s, BXLIV Media\'s, or partners\' reputation. Protect the ecosystem we\'ve built.',
        'color': const Color(0xFF26d9d0),
      },
      {
        'icon': Icons.privacy_tip_rounded,
        'title': 'Privacy & IP Rights',
        'description':
            'Respect others\' privacy, use only owned or licensed content, and avoid violating intellectual property rights.',
        'color': AppColors.accentMagenta,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 50 : 80,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'CONDUCT EXPECTATIONS',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.accentMagenta,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Key Principles & Standards',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w800,
              color: Colors.black,
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
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio:  isMobile ? 1.4 : 1.7,
                children: conductItems
                    .map(
                      (item) => _conductCard(
                        icon: item['icon'] as IconData,
                        title: item['title'] as String,
                        description: item['description'] as String,
                        color: item['color'] as Color,
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

  Widget _conductCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
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

  // Disciplinary Actions Section
  Widget _buildDisciplinarySection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 50 : 80,
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
          // Intro text
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.accentMagenta.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.accentMagenta,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Consequences for Violations',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accentMagenta,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'In case of violations of this Code of Conduct, BXLIV Media reserves the right to:',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.7,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                _disciplinaryItem(
                  title: 'Issue Warnings',
                  description: 'Initial warnings for minor violations',
                ),
                const SizedBox(height: 12),
                _disciplinaryItem(
                  title: 'Temporary Suspension',
                  description: 'Suspend support or cooperation temporarily',
                ),
                const SizedBox(height: 12),
                _disciplinaryItem(
                  title: 'Contract Termination',
                  description:
                      'Terminate contractual relationship for serious violations',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _disciplinaryItem({
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.accentMagenta.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.accentMagenta,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Declaration Section
  Widget _buildDeclarationSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 50 : 80,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.accentMagenta.withOpacity(0.1),
                  const Color(0xFF26d9d0).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.accentMagenta.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.accentMagenta,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Creator Agreement',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'By joining BXLIV Media, you acknowledge that you have reviewed and agree to comply fully with this Creator Code of Conduct and all applicable TikTok policies.',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.8,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: (){
                      _navigateTo(context, AppRoutes.forCreators);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentMagenta,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'I Agree & Commit',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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
   void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}