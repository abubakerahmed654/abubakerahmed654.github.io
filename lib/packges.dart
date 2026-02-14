import 'package:bxliv_media/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PackagesSection extends StatelessWidget {
  const PackagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    final packages = [
      {
        'title': 'Starter',
        'subtitle': 'Perfect for testing TikTok marketing',
        'isPopular': false,
        'features': [
          '5-10 Creator campaign',
          'Basic analytics report',
          '1 campaign concept',
          '2-week turnaround',
        ],
        'color': const Color(0xFFFBE8F3),
      },
      {
        'title': 'Growth',
        'subtitle': 'Scale your TikTok presence',
        'isPopular': true,
        'features': [
          '15-25 Creator campaign',
          'Advanced analytics dashboard',
          '3 campaign concepts',
          'Trend-based content',
          'Dedicated account manager',
        ],
        'color': const Color(0xFFFBE8F3),
      },
      {
        'title': 'Enterprise',
        'subtitle': 'Full-service partnership',
        'isPopular': false,
        'features': [
          'Unlimited creators',
          'Real-time analytics',
          'Custom content strategy',
          'Exclusive creator access',
          'Priority support',
          'Quarterly strategy sessions',
        ],
        'color': const Color(0xFFE8F9F7),
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 150,
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
                  text: 'PACKAGES',
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
          Text(
            'Flexible options for every budget and goal.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 14 : 18,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          // Packages grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isMobile ? 1 : 3;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: isMobile ? 0.9 : .85,
                children: packages
                    .map(
                      (pkg) => _packageCard(
                        title: pkg['title'] as String,
                        subtitle: pkg['subtitle'] as String,
                        features: pkg['features'] as List<String>,
                        isPopular: pkg['isPopular'] as bool,
                        bgColor: pkg['color'] as Color,
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

  Widget _packageCard({
    required String title,
    required String subtitle,
    required List<String> features,
    required bool isPopular,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPopular
              ? AppColors.accentMagenta
              : Colors.grey[300]!,
          width: isPopular ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular badge
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.accentMagenta,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'MOST POPULAR',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          SizedBox(height: isPopular ? 16 : 0),
          // Title
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          // Divider
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 24),
          // Features
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features
                  .map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFF26d9d0),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: GoogleFonts.inter(
                                fontSize: 14,
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
}
