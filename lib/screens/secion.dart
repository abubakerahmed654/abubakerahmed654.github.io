// ignore_for_file: deprecated_member_use

import 'package:bxliv_media/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: _isHovered
              ? Border.all(
                  color: AppColors.accentMagenta,
                  width: 2,
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: widget.iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                widget.icon,
                color: widget.iconColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isHovered ? AppColors.accentMagenta : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                widget.description,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaseStudyCard extends StatefulWidget {
  final String title;
  final String tag;
  final String views;
  final String likes;
  final String shares;
  final Color tagColor;
  final String imageUrl;
  final String? description;
  final List<String>? badges;

  const CaseStudyCard({
    super.key,
    required this.title,
    required this.tag,
    required this.views,
    required this.likes,
    required this.shares,
    required this.tagColor,
    required this.imageUrl,
    this.description,
    this.badges,
  });

  @override
  State<CaseStudyCard> createState() => _CaseStudyCardState();
}

class _CaseStudyCardState extends State<CaseStudyCard> {
  bool _isHovered = false;

  Color _getBackgroundColor() {
    if (widget.tagColor == AppColors.accentMagenta) {
      return const Color(0xFFFBE8F3); // Light pink
    } else {
      return const Color(0xFFE8F9F7); // Light cyan
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getBackgroundColor();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? AppColors.accentMagenta : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 12)]
              : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Section - FIXED HEIGHT 200px, FULL WIDTH
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Image with zoom animation - FILLS ENTIRE STACK
                    Positioned.fill(
                      child: AnimatedScale(
                        scale: _isHovered ? 1.08 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey[300]),
                        ),
                      ),
                    ),
                    // Tag Badge (Top Left)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: widget.tagColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.tag,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Content Section - SAME WIDTH AS IMAGE (full width)
              Container(
                width: double.infinity,
                color: bgColor,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      widget.title,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.description!,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 12),
                    // Stats Row
                    Row(
                      children: [
                        _stat(Icons.visibility_outlined, widget.views),
                        const SizedBox(width: 16),
                        _stat(Icons.favorite_outline, widget.likes),
                        const SizedBox(width: 16),
                        _stat(Icons.share_outlined, widget.shares),
                      ],
                    ),
                    // Badges
                    if (widget.badges != null && widget.badges!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, bottom: 16),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.badges!
                              .map((badge) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.accentCyan2.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      badge,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                     //   fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ] else
                      const SizedBox(height: 0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[700], size: 16),
        const SizedBox(width: 6),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
           // fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
