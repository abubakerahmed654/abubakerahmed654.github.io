// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:bxliv_media/app_routes.dart';
import 'package:bxliv_media/navbar.dart';
import 'package:bxliv_media/screens/secion.dart';
import 'package:bxliv_media/section2.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _isHoveredViewServices = false;
  bool _isHoveredViewCases = false;
  bool _isHoveredGetInTouch = false;
  bool _isHoveredJoinRoster = false;
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
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
                _buildWhatWeDoSection(context),
                _buildFeaturesSection(context),
                _buildOurWorkSection(context),
                _buildTestimonialsSection(context),
                _buildCtaSection(context),
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

  Widget _buildOurWorkSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    final List<CaseStudyCard2> items = [
      CaseStudyCard2(
        title: 'Fashion Nova Campaign',
        tag: 'Brand Campaign',
        views: '45M',
        likes: '3.2M',
        shares: '890K',
        tagColor: AppColors.accentMagenta.withOpacity(.3),
        imageUrl:
            'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ),
      CaseStudyCard2(
        title: 'Gaming Creator Launch',
        tag: 'Creator Growth',
        views: '28M',
        likes: '2.1M',
        shares: '520K',
        tagColor: AppColors.accentCyan2.withOpacity(0.3),
        imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=500',
      ),
      CaseStudyCard2(
        title: 'Viral Dance Challenge',
        tag: 'Content Strategy',
        views: '120M',
        likes: '8.5M',
        shares: '2.3M',
        tagColor: AppColors.accentMagenta.withOpacity(.3),
        imageUrl: 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?q=80&w=500',
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: isMobile ? 60 : 100,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'OUR ',
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 32 : 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'WORK',
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 32 : 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentCyan2,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isMobile)
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveredViewCases = true),
                  onExit: (_) => setState(() => _isHoveredViewCases = false),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _navigateTo(context, AppRoutes.caseStudies);
                    },
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.arrow_outward, size: 18),
                    label: Text(
                      'View All Cases',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isHoveredViewCases ? AppColors.accentCyan2 : Colors.white,
                      foregroundColor:
                          _isHoveredViewCases ? Colors.white : Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: _isHoveredViewCases ? AppColors.accentCyan2 : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Real results from real campaigns. See how we\'ve helped creators and brands go viral.',
            style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[700]),
          ),
          const SizedBox(height: 40),
          isMobile
              ? Column(
                  children: items
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: item,
                          ))
                      .toList(),
                )
              : Row(
                  children: items
                      .map((item) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: item,
                            ),
                          ))
                      .toList(),
                ),
                 if (isMobile)
                Center(
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isHoveredViewCases = true),
                    onExit: (_) => setState(() => _isHoveredViewCases = false),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _navigateTo(context, AppRoutes.caseStudies);
                      },
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.arrow_outward, size: 18),
                      label: Text(
                        'View All Cases',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isHoveredViewCases ? AppColors.accentCyan2 : Colors.white,
                        foregroundColor:
                            _isHoveredViewCases ? Colors.white : Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: _isHoveredViewCases ? AppColors.accentCyan2 : Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  Widget _buildHeroSection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [
            Color(0xFFFBE8F3),
            Color(0xFFE8F9F7),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80,
          vertical: isMobile ? 40 : 60,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            buildTikTokAgencyBadge(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Image.asset(
                      'assets/1.webp',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'WE BUILD\n',
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 42 : 72,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.1,
                    ),
                  ),
                  TextSpan(
                    text: 'TikTok VIRAL ',
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 42 : 72,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentMagenta,
                      height: 1.1,
                    ),
                  ),
                  TextSpan(
                    text: 'EMPIRES',
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 42 : 72,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF26d9d0),
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'From creator/gamer management to brand campaigns, we turn TikTok presence into cultural movements.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: isMobile ? 14 : 18,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 48),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () {
                    _navigateTo(context, AppRoutes.forBrands);
                  },
                  icon: const Icon(Icons.arrow_forward, size: 18),
                  label: Text(
                    'Partner With Us',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentMagenta,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              MouseRegion(
  onEnter: (_) => setState(() => _isHoveredJoinRoster = true),
  onExit: (_) => setState(() => _isHoveredJoinRoster = false),
  child: OutlinedButton.icon(
    onPressed: () {
      _navigateTo(context, AppRoutes.forCreators);
    },
   // iconAlignment: IconAlignment.end,
    icon: Icon(
      Icons.play_arrow_outlined,
      size: 18,
      color: _isHoveredJoinRoster ? Colors.white : Colors.black,
    ),
    label: Text(
      'Join Our Roster',
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: _isHoveredJoinRoster ? Colors.white : Colors.black,
      ),
    ),
    style: OutlinedButton.styleFrom(
      backgroundColor: _isHoveredJoinRoster ? AppColors.accentCyan2 : Colors.white,
      side: BorderSide(
        color: _isHoveredJoinRoster ? AppColors.accentCyan2 : Colors.black.withOpacity(0.3),
        width: 1,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
)
              ],
            ),
            const SizedBox(height: 60),
            Wrap(
              spacing: isMobile ? 40 : 80,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              children: [
                _statItem('500+', 'Creators Managed'),
                _statItem('2B+', 'Views Generated'),
                _statItem('150+', 'Brand Partners'),
                _statItem('98%', 'Client Retention'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String number, String label) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          Text(
            number,
            style: GoogleFonts.inter(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.accentMagenta,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 200,
        vertical: isMobile ? 60 : 50,
      ),
      color: Colors.white,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isMobile ? 1 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: isMobile ? 1.3 : 2.0,
                children: const [
                  ServiceCard(
                    title: 'Creator Management',
                    description:
                        'Full-service talent management for TikTok creators. From contract negotiations to career development.',
                    icon: Icons.people,
                    iconColor: AppColors.accentMagenta,
                  ),
                  ServiceCard(
                    title: 'Brand Marketing',
                    description:
                        'Strategic campaigns that connect brands with the right creators and audiences for maximum impact.',
                    icon: Icons.campaign,
                    iconColor: AppColors.accentCyan,
                  ),
                  ServiceCard(
                    title: 'Content Creation',
                    description:
                        'Professional content production that captures attention and drives engagement across platforms.',
                    icon: Icons.videocam,
                    iconColor: AppColors.accentMagenta,
                  ),
                  ServiceCard(
                    title: 'Gaming Division',
                    description:
                        'Specialized management and marketing for gaming creators and esports personalities.',
                    icon: Icons.sports_esports,
                    iconColor: AppColors.accentCyan,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 48),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _isHoveredViewServices = true),
            onExit: (_) => setState(() => _isHoveredViewServices = false),
            child: GestureDetector(
              onTap: () {
                _navigateTo(context, AppRoutes.services);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View All Services',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentMagenta,
                      decoration: _isHoveredViewServices
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.arrow_outward,
                    color: AppColors.accentMagenta,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
            Color(0xFFFBE8F3),
            Color(0xFFE8F9F7),
          ],
        ),
      ),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'WHAT WE ',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'DO',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPink,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: isMobile ? double.infinity : 800,
            child: Text(
              'Comprehensive services designed to elevate creators and amplify brands in the TikTok ecosystem.',
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

  Widget _buildTestimonialsSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [
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
                  text: 'WHAT THEY ',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'SAY',
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPink,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: isMobile ? double.infinity : 800,
            child: Text(
              'Don\'t just take our word for it. Here\'s what our creators and clients have to say.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: isMobile ? 16 : 18,
                color: Colors.black,
                height: 1.6,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          LayoutBuilder(
            builder: (context, constraints) {
              if (isMobile) {
                return Column(
                  children: [
                    _testimonialCard(
                      'BXLIV transformed my TikTok career. They helped me grow from 50K to 2M followers in just 8 months.',
                      'Alex Chen',
                      'Lifestyle Creator',
                      '',
                    ),
                    const SizedBox(height: 20),
                    _testimonialCard(
                      'The campaign results were incredible. 10x our usual engagement and sales through the roof.',
                      'Sarah Mitchell',
                      'Marketing Director, BrandCo',
                      '',
                    ),
                    const SizedBox(height: 20),
                    _testimonialCard(
                      'Finally, an agency that understands the gaming space. They\'ve been instrumental in my esports journey.',
                      'Marcus Wong',
                      'Gaming Creator',
                      '',
                    ),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _testimonialCard(
                      'BXLIV transformed my TikTok career. They helped me grow from 50K to 2M followers in just 8 months.',
                      'Alex Chen',
                      'Lifestyle Creator',
                      '',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _testimonialCard(
                      'The campaign results were incredible. 10x our usual engagement and sales through the roof.',
                      'Sarah Mitchell',
                      'Marketing Director, BrandCo',
                      '',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _testimonialCard(
                      'Finally, an agency that understands the gaming space. They\'ve been instrumental in my esports journey.',
                      'Marcus Wong',
                      'Gaming Creator',
                      '',
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _testimonialCard(
    String quote,
    String name,
    String title,
    String imageUrl,
  ) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFFBE8F3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.star_rounded,
                  color: AppColors.accentMagenta,
                  size: 20,
                  fill: 1.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '"$quote"',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.black,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              imageUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(imageUrl),
                      backgroundColor: Colors.grey[300],
                    )
                  : CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.accentMagenta.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        color: AppColors.accentMagenta,
                        size: 32,
                      ),
                    ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTikTokAgencyBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF26d9d0),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'TikTok Agency for Creators & Brands',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 200,
        vertical: isMobile ? 60 : 100,
      ),
      color: Colors.white,
      child: Column(
        children: [
          // Creators CTA Box
          Container(
            padding: EdgeInsets.all(isMobile ? 32 : 48),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.accentMagenta.withOpacity(0.25),
                  AppColors.accentMagenta.withOpacity(0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                         Icons.star_purple500_rounded,
                            color: AppColors.accentMagenta,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'FOR CREATORS',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentMagenta,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Ready to go viral?',
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Join our roster of top-tier TikTok creators. We\'ll help you grow, monetize, and build your brand.',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          _navigateTo(context, AppRoutes.forCreators);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentMagenta,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Apply Now',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star_purple500_rounded,
                                  color: AppColors.accentMagenta,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'FOR CREATORS',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.accentMagenta,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Ready to go viral?',
                              style: GoogleFonts.inter(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Join our roster of top-tier TikTok creators. We\'ll help you grow, monetize, and build your brand.',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.grey[700],
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      ElevatedButton.icon(
                        onPressed: () {
                          _navigateTo(context, AppRoutes.forCreators);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentMagenta,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Apply Now',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 24),
          // Brands CTA Box
          Container(
            padding: EdgeInsets.all(isMobile ? 32 : 48),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.accentCyan2.withOpacity(0.25),
                  AppColors.accentCyan2.withOpacity(0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                         Icons.star_purple500_rounded,
                            color: AppColors.accentCyan2,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'FOR BRANDS',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentCyan2,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Want to reach millions?',
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Partner with us for campaigns that move culture and drive results. Let\'s create something unforgettable.',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      MouseRegion(
                        onEnter: (_) =>
                            setState(() => _isHoveredGetInTouch = true),
                        onExit: (_) =>
                            setState(() => _isHoveredGetInTouch = false),
                        child: OutlinedButton.icon(
                          iconAlignment: IconAlignment.end,
                          onPressed: () {
                            _navigateTo(context, AppRoutes.forBrands);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: _isHoveredGetInTouch
                                  ? AppColors.accentCyan2
                                  : AppColors.accentCyan2,
                              width: 1,
                            ),
                            backgroundColor: _isHoveredGetInTouch
                                ? AppColors.accentCyan2
                                : Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: _isHoveredGetInTouch
                                ? Colors.white
                                : AppColors.accentCyan2,
                          ),
                          label: Text(
                            'Get In Touch',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: _isHoveredGetInTouch
                                  ? Colors.white
                                  : AppColors.accentCyan2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                       Icons.star_purple500_rounded,
                                  color: AppColors.accentCyan2,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'FOR BRANDS',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.accentCyan2,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Want to reach millions?',
                              style: GoogleFonts.inter(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Partner with us for campaigns that move culture and drive results. Let\'s create something unforgettable.',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.grey[700],
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      MouseRegion(
                        onEnter: (_) =>
                            setState(() => _isHoveredGetInTouch = true),
                        onExit: (_) =>
                            setState(() => _isHoveredGetInTouch = false),
                        child: OutlinedButton.icon(
                          iconAlignment: IconAlignment.end,
                          onPressed: () {
                            _navigateTo(context, AppRoutes.forBrands);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: _isHoveredGetInTouch
                                  ? AppColors.accentCyan2
                                  : AppColors.accentCyan2,
                              width: 1,
                            ),
                            backgroundColor: _isHoveredGetInTouch
                                ? AppColors.accentCyan2
                                : Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: _isHoveredGetInTouch
                                ? Colors.white
                                : AppColors.accentCyan2,
                          ),
                          label: Text(
                            'Get In Touch',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: _isHoveredGetInTouch
                                  ? Colors.white
                                  : AppColors.accentCyan2,
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
}