// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bxliv_media/main.dart';
import 'app_routes.dart';

class BXLIVNavBar extends StatelessWidget {
  final ScrollController? scrollController;
  final bool isScrolled;
  final String currentRoute;
  final VoidCallback? onMenuPressed;

  const BXLIVNavBar({
    super.key,
    this.scrollController,
    this.isScrolled = false,
    this.currentRoute = AppRoutes.home,
    this.onMenuPressed,
  });

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 80,
      decoration: BoxDecoration(
        color: isScrolled
            ? AppColors.bgLight.withOpacity(0.95)
            : Colors.transparent,
        boxShadow: isScrolled
            ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]
            : [],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo (Left) - Fixed width
            GestureDetector(
              onTap: () => _navigateTo(context, AppRoutes.home),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'BXLIV',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryPink,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'MEDIA',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textGray,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!isMobile) ...[
              // Navigation links (Center)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _navLink(context, 'Home', AppRoutes.home, currentRoute),
                    const SizedBox(width: 24),
                    _navLink(context, 'About', AppRoutes.about, currentRoute),
                    const SizedBox(width: 24),
                    _navLink(context, 'Services', AppRoutes.services, currentRoute),
                    const SizedBox(width: 24),
                    _navLink(context, 'Case Studies', AppRoutes.caseStudies, currentRoute),
                    const SizedBox(width: 24),
                    _navLink(context, 'For Creators', AppRoutes.forCreators, currentRoute),
                    const SizedBox(width: 24),
                    _navLink(context, 'For Brands', AppRoutes.forBrands, currentRoute),
                  ],
                ),
              ),
              // Right side elements - Fixed width
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Theme toggle
                  // MouseRegion(
                  //   cursor: SystemMouseCursors.click,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       // Implement theme toggle
                  //     },
                  //     child: const Icon(
                  //       Icons.wb_sunny_outlined,
                  //       color: AppColors.textGray,
                  //       size: 20,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 20),
                  // Login
                  GestureDetector(
                    onTap: () => _navigateTo(context, AppRoutes.login),
                    child: const MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: AppColors.textGray,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Get Started button
                  ElevatedButton(
                    onPressed: () =>
                        _navigateTo(context, AppRoutes.forCreators),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPink,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              GestureDetector(
                onTap: onMenuPressed,
                child: const Icon(Icons.menu, color: AppColors.textGray),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _navLink(BuildContext context, String text, String route, String currentRoute) {
    // Get the actual current route from navigation
    final actualCurrentRoute = ModalRoute.of(context)?.settings.name ?? currentRoute;
    final isActive = actualCurrentRoute == route;

    return GestureDetector(
      onTap: () => _navigateTo(context, route),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: isActive ? AppColors.accentMagenta : AppColors.textGray,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// Footer
Widget buildFooter(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 800;

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 20 : 80,
      vertical: isMobile ? 40 : 60,
    ),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFFBE8F3), // Light pink
          Color(0xFFE8F9F7), // Light cyan
        ],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        'assets/1.webp',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 280,
                    child: Text(
                      'The premier TikTok agency for creators and brands. We build communities, grow audiences, and create viral content.',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Social icons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _socialIcon(FontAwesomeIcons.instagram),
                      const SizedBox(width: 12),
                      _socialIcon(FontAwesomeIcons.xTwitter),
                      const SizedBox(width: 12),
                      _socialIcon(FontAwesomeIcons.youtube),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 100),
              Expanded(
                flex: 1,
                child: _footerLinks(context, 'Company', [
                  ('About Us', AppRoutes.about),
                ]),
              ),
              Expanded(
                flex: 1,
                child: _footerLinks(context, 'Services', [
                  ('Creator Management', AppRoutes.services),
                  ('Brand Marketing', AppRoutes.services),
                  ('Content Creation', AppRoutes.services),
                ]),
              ),
              Expanded(
                flex: 1,
                child: _footerLinks(context, 'Resources', [
                  ('For Creators', AppRoutes.forCreators),
                  ('For Brands', AppRoutes.forBrands),
                ]),
              ),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(
                    'assets/1.webp',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'The premier TikTok agency for creators and brands. We build communities, grow audiences, and create viral content.',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey[700],
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _socialIcon(FontAwesomeIcons.instagram),
                  const SizedBox(width: 12),
                  _socialIcon(FontAwesomeIcons.xTwitter),
                  const SizedBox(width: 12),
                  _socialIcon(FontAwesomeIcons.youtube),
                ],
              ),
               const SizedBox(height: 20),
                _footerLinks(context, 'Company', [
                  ('About Us', AppRoutes.about),
                ]),
                 const SizedBox(height: 10),
              _footerLinks(context, 'Services', [
                ('Creator Management', AppRoutes.services),
                ('Brand Marketing', AppRoutes.services),
                ('Content Creation', AppRoutes.services),
              ]),
               const SizedBox(height: 10),
              _footerLinks(context, 'Resources', [
                ('For Creators', AppRoutes.forCreators),
                ('For Brands', AppRoutes.forBrands),
              ]),
            ],
          ),
        SizedBox(height: isMobile ? 40 : 60),
        Container(
          height: 1,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 30),
        if (!isMobile)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2026 B X LIV. All rights reserved.',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _footerLink(context, 'Privacy Policy', AppRoutes.codeOfConduct),
                  const SizedBox(width: 32),
                  _footerLink(context, 'Terms of Service', AppRoutes.codeOfConduct),
                ],
              ),
            ],
          )
        else
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '© 2026 B X LIV. All rights reserved.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _footerLink(context, 'Privacy Policy', AppRoutes.codeOfConduct),
                    const SizedBox(width: 20),
                    _footerLink(context, 'Terms of Service', AppRoutes.codeOfConduct),
                  ],
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _footerLinks(
  BuildContext context,
  String title,
  List<(String label, String? route)> links,
) {
  return Column(
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
      const SizedBox(height: 16),
      ...links.map((link) {
        final label = link.$1;
        final route = link.$2;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: route != null
                ? () => Navigator.pushNamed(context, route)
                : null,
            child: MouseRegion(
              cursor: route != null
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        );
      }),
    ],
  );
}

Widget _footerLink(BuildContext context, String text, String route) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, route),
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: AppColors.textGray,
        ),
      ),
    ),
  );
}

Widget _socialIcon(IconData icon) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        icon,
        size: 20,
        color: Colors.black,
      ),
    ),
  );
}



  Widget buildMobileDrawer(BuildContext context) {
  
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
        //  padding: const EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'BXLIV',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryPink,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'MEDIA',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textGray,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Navigation Items
            _drawerItem(context, 'Home', AppRoutes.home),
            _drawerItem(context, 'About', AppRoutes.about),
            _drawerItem(context, 'Services', AppRoutes.services),
            _drawerItem(context, 'Case Studies', AppRoutes.caseStudies),
            _drawerItem(context, 'For Creators', AppRoutes.forCreators),
            _drawerItem(context, 'For Brands', AppRoutes.forBrands),
            _drawerItem(context, 'Code of Conduct', AppRoutes.codeOfConduct),
            const Divider(),
          
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _navigateTo(context, AppRoutes.login);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentCyan2,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _navigateTo(context, AppRoutes.forCreators);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentMagenta,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          // side: BorderSide(
                          //   color: Colors.black.withOpacity(0.3),
                          //   width: 2,
                          // ),
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
   void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }


  Widget _drawerItem(BuildContext context, String text, String route) {
    final isActive = ModalRoute.of(context)?.settings.name == route;
    
    return ListTile(
      title: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          color: isActive ? AppColors.accentMagenta : Colors.black,
        ),
      ),
      // leading: isActive
      //     ? Container(
      //         width: 4,
      //         height: 4,
      //         decoration: BoxDecoration(
      //           color: AppColors.accentMagenta,
      //           borderRadius: BorderRadius.circular(2),
      //         ),
      //       )
      //     : null,
      onTap: () {
        Navigator.pop(context);
        _navigateTo(context, route);
      },
    );
  }