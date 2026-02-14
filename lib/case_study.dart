// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:bxliv_media/app_routes.dart';
import 'package:bxliv_media/navbar.dart';
import 'package:bxliv_media/screens/secion.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class CaseStudy extends StatefulWidget {
  const CaseStudy({super.key});

  @override
  State<CaseStudy> createState() => _CaseStudyState();
}

class _CaseStudyState extends State<CaseStudy> {
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
         
                _buildWhatWeDoSection(context),
                _buildOurWorkSection(context),
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

  // Our Work Section - Grid Layout (3 columns)
  Widget _buildOurWorkSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    final List<CaseStudyCard> items = [
      const CaseStudyCard(
        title: 'Fashion Nova Campaign',
        tag: 'Brand Campaign',
        views: '45M',
        likes: '3.2M',
        shares: '890K',
        tagColor: AppColors.accentMagenta,
        imageUrl:
            'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        description: 'A viral fashion challenge that broke TikTok records and drove 300% increase in sales.',
        badges: ['300% sales increase', '45M organic views'],
      ),
      const CaseStudyCard(
        title: 'Gaming Creator Launch',
        tag: 'Creator Growth',
        views: '28M',
        likes: '2.1M',
        shares: '520K',
       tagColor: AppColors.accentMagenta,
        imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=500',
        description: 'Taking a gaming creator from 10K to 1M followers in just 4 months.',
        badges: ['10K to 1M followers', 'Brand deal signed'],
      ),
      const CaseStudyCard(
        title: 'Viral Dance Challenge',
        tag: 'Content Strategy',
        views: '120M',
        likes: '8.5M',
        shares: '2.3M',
       tagColor: AppColors.accentMagenta,
        imageUrl:
            'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?q=80&w=500',
        description: 'Creating a dance challenge that became a global phenomenon.',
        badges: ['120M total views', '2.3M UGC videos'],
      ),
      const CaseStudyCard(
        title: 'Beauty Brand Collab',
        tag: 'Influencer Marketing',
        views: '85M',
        likes: '6.2M',
        shares: '1.5M',
   tagColor: AppColors.accentMagenta,
        imageUrl:
            'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?q=80&w=500',
        description: 'Partnered with beauty brand for influencer-driven campaign.',
        badges: ['\$2.5M product sales', '15K creator network'],
      ),
      const CaseStudyCard(
        title: 'Music Producer Series',
        tag: 'Creator Growth',
        views: '95M',
        likes: '7.1M',
        shares: '1.8M',
      tagColor: AppColors.accentMagenta,
        imageUrl:
            'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?q=80&w=500',
        description: 'Launched a music producer from zero to 500K followers.',
        badges: ['500K followers', 'Spotify featured'],
      ),
      const CaseStudyCard(
        title: 'Fitness Challenge 2024',
        tag: 'Content Strategy',
        views: '110M',
        likes: '8.0M',
        shares: '2.1M',
  tagColor: AppColors.accentMagenta,
        imageUrl:
            'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?q=80&w=500',
        description: 'Global fitness challenge with 100K+ user-generated videos.',
        badges: ['100K submissions', '50K+ gym sign-ups'],
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [
            Color(0xFFFBE8F3), // Light pink
            Color(0xFFE8F9F7), // Light cyan
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          // Grid Layout - 3 columns on desktop, 1 on mobile
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : 3,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio:  isMobile ? 1.2 : 1,
            children: items,
          ),
        ],
      ),
    );
  }

  // Case Studies Section Header
  Widget _buildWhatWeDoSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 400,
        vertical: isMobile ? 60 : 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [
            Color(0xFFFBE8F3), // Light pink
             Color(0xFFFBE8F3), // Light cyan
          ],
        ),
      ),
      child: Column(
        
        children: [
          SizedBox(height: 60),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'CASE ',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'STUDIES',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentCyan2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: isMobile ? double.infinity : 800,
            child: Text(
              "Real campaigns, real results. See how we've helped creators and brands achieve viral success.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: isMobile ? 16 : 18,
                color: AppColors.textGray,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
