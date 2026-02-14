// ignore_for_file: deprecated_member_use

import 'package:bxliv_media/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'admin_controller.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());
    final isMobile = context.width < 800;
    final isTablet = context.width >= 800 && context.width < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      drawer: isMobile ? _Sidebar(controller: controller) : null,
      body: Row(
        children: [
          if (!isMobile) _Sidebar(controller: controller),
          Expanded(
            child: Column(
              children: [
                _TopBar(isMobile: isMobile),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accentMagenta,
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(isMobile ? 16 : 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _StatsRow(
                            controller: controller,
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 28),
                          _FiltersBar(
                            controller: controller,
                            isMobile: isMobile,
                          ),
                          const SizedBox(height: 20),
                          _ApplicationsList(
                            controller: controller,
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SIDEBAR
// ═══════════════════════════════════════════════════════════════
class _Sidebar extends StatelessWidget {
  final AdminController controller;
  const _Sidebar({required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.width < 800;

    return Container(
      width: isMobile ? 280 : 260,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'B ',
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                TextSpan(
                  text: '✕ ',
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.accentMagenta),
                ),
                TextSpan(
                  text: 'LIV',
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ]),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColors.accentMagenta.withOpacity(0.3),
                  AppColors.accentCyan2.withOpacity(0.3),
                ]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ADMIN PANEL',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 48),
            const _SidebarItem(
                icon: Icons.dashboard_rounded,
                label: 'Dashboard',
                isActive: true),
            const _SidebarItem(
                icon: Icons.people_rounded,
                label: 'Applications',
                isActive: false),
            const _SidebarItem(
                icon: Icons.analytics_rounded,
                label: 'Analytics',
                isActive: false),
            const _SidebarItem(
                icon: Icons.settings_rounded,
                label: 'Settings',
                isActive: false),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () => controller.logout(),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.logout_rounded,
                          color: Colors.red[300], size: 20),
                      const SizedBox(width: 12),
                      Text(
                        'Logout',
                        style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: Colors.red[300],
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  const _SidebarItem(
      {required this.icon, required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        gradient: isActive
            ? LinearGradient(colors: [
                AppColors.accentMagenta.withOpacity(0.2),
                AppColors.accentCyan2.withOpacity(0.1),
              ])
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon,
            color: isActive ? AppColors.accentMagenta : Colors.white38,
            size: 20),
        title: Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: isActive ? Colors.white : Colors.white54,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  TOP BAR
// ═══════════════════════════════════════════════════════════════
class _TopBar extends StatelessWidget {
  final bool isMobile;
  const _TopBar({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 28,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (isMobile)
            Builder(
              builder: (ctx) => IconButton(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                icon: const Icon(Icons.menu_rounded, size: 24),
              ),
            ),
          if (isMobile) const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: isMobile ? 22 : 26,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              Text(
                'Manage all incoming applications',
                style: GoogleFonts.dmSans(fontSize: 13, color: Colors.grey[500]),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [AppColors.accentMagenta, Color(0xFF26d9d0)]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'A',
                style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  STATS ROW
// ═══════════════════════════════════════════════════════════════
class _StatsRow extends StatelessWidget {
  final AdminController controller;
  final bool isMobile;
  final bool isTablet;

  const _StatsRow({
    required this.controller,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final stats = [
        _StatData('Total', controller.totalCount, Icons.inbox_rounded,
            [const Color(0xFF667EEA), const Color(0xFF764BA2)]),
        _StatData('Creators', controller.creatorsCount, Icons.person_rounded,
            [AppColors.accentMagenta, const Color(0xFFFF6B9D)]),
        _StatData('Brands', controller.brandsCount, Icons.business_rounded,
            [AppColors.accentCyan2, const Color(0xFF26d9d0)]),
        _StatData('Pending', controller.pendingCount, Icons.schedule_rounded,
            [const Color(0xFFf5a623), const Color(0xFFf7c948)]),
        _StatData('Approved', controller.approvedCount,
            Icons.check_circle_rounded,
            [const Color(0xFF00C853), const Color(0xFF69F0AE)]),
        _StatData('Rejected', controller.rejectedCount,
            Icons.cancel_rounded,
            [const Color(0xFFFF5252), const Color(0xFFFF8A80)]),
      ];

      if (isMobile) {
        return Column(
          children: [
            for (int i = 0; i < stats.length; i += 2)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(child: _StatCard(stat: stats[i], isMobile: true)),
                    const SizedBox(width: 12),
                    if (i + 1 < stats.length)
                      Expanded(
                          child:
                              _StatCard(stat: stats[i + 1], isMobile: true))
                    else
                      const Expanded(child: SizedBox()),
                  ],
                ),
              ),
          ],
        );
      }

      if (isTablet) {
        return Column(
          children: [
            Row(
              children: stats
                  .sublist(0, 3)
                  .map((s) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: _StatCard(stat: s, isMobile: false),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: stats
                  .sublist(3)
                  .map((s) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: _StatCard(stat: s, isMobile: false),
                        ),
                      ))
                  .toList(),
            ),
          ],
        );
      }

      return Row(
        children: stats
            .map((s) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: _StatCard(stat: s, isMobile: false),
                  ),
                ))
            .toList(),
      );
    });
  }
}

class _StatCard extends StatelessWidget {
  final _StatData stat;
  final bool isMobile;
  const _StatCard({required this.stat, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[100]!),
          boxShadow: [
            BoxShadow(
              color: stat.colors[0].withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: stat.colors),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(stat.icon, color: Colors.white, size: 18),
                ),
                TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 0, end: stat.count),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) {
                    return Text(
                      value.toString(),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: isMobile ? 26 : 32,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1A2E),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              stat.label,
              style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  FILTERS BAR
// ═══════════════════════════════════════════════════════════════
class _FiltersBar extends StatelessWidget {
  final AdminController controller;
  final bool isMobile;
  const _FiltersBar({required this.controller, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 14 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: isMobile
          ? Column(
              children: [
                _SearchField(controller: controller),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _StatusFilter(controller: controller)),
                    const SizedBox(width: 10),
                    Expanded(child: _TypeFilter(controller: controller)),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(flex: 3, child: _SearchField(controller: controller)),
                const SizedBox(width: 16),
                Expanded(flex: 2, child: _StatusFilter(controller: controller)),
                const SizedBox(width: 12),
                Expanded(flex: 2, child: _TypeFilter(controller: controller)),
              ],
            ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final AdminController controller;
  const _SearchField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: controller.setSearchQuery,
      decoration: InputDecoration(
        hintText: 'Search by name or email...',
        hintStyle: GoogleFonts.dmSans(fontSize: 13, color: Colors.grey[400]),
        prefixIcon:
            Icon(Icons.search_rounded, color: Colors.grey[400], size: 20),
        filled: true,
        fillColor: const Color(0xFFF7F8FC),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: GoogleFonts.dmSans(fontSize: 14, color: const Color(0xFF1A1A2E)),
    );
  }
}

class _StatusFilter extends StatelessWidget {
  final AdminController controller;
  const _StatusFilter({required this.controller});

  @override
  Widget build(BuildContext context) {
    final statuses = ['All', 'Pending', 'Approved', 'Rejected'];
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: controller.selectedFilter.value,
            underline: const SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.grey[500], size: 20),
            style: GoogleFonts.dmSans(
                fontSize: 13, color: const Color(0xFF1A1A2E)),
            items: statuses
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (val) => controller.setStatusFilter(val ?? 'All'),
          ),
        ));
  }
}

class _TypeFilter extends StatelessWidget {
  final AdminController controller;
  const _TypeFilter({required this.controller});

  @override
  Widget build(BuildContext context) {
    final types = ['All', 'Creator', 'Brand'];
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: controller.selectedTypeFilter.value,
            underline: const SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.grey[500], size: 20),
            style: GoogleFonts.dmSans(
                fontSize: 13, color: const Color(0xFF1A1A2E)),
            items: types
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (val) =>
                controller.setTypeFilter(val ?? 'All'),
          ),
        ));
  }
}

// ═══════════════════════════════════════════════════════════════
//  APPLICATIONS LIST
// ═══════════════════════════════════════════════════════════════
class _ApplicationsList extends StatelessWidget {
  final AdminController controller;
  final bool isMobile;
  final bool isTablet;

  const _ApplicationsList({
    required this.controller,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.filteredApplications;

      if (data.isEmpty) {
        return _EmptyState();
      }

      if (isMobile) {
        return Column(
          children: data
              .map((d) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child:
                        _ApplicationCard(data: d, controller: controller),
                  ))
              .toList(),
        );
      }

      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[100]!),
        ),
        child: Column(
          children: [
            _TableHeader(isTablet: isTablet),
            ...data.map(
                (d) => _TableRow(data: d, isTablet: isTablet, controller: controller)),
          ],
        ),
      );
    });
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(Icons.inbox_rounded, size: 56, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No applications found',
            style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400]),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final bool isTablet;
  const _TableHeader({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.dmSans(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.grey[500],
      letterSpacing: 0.5,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFD),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('Applicant', style: style)),
          if (!isTablet)
            Expanded(flex: 2, child: Text('Contact', style: style)),
          Expanded(flex: 1, child: Text('Type', style: style)),
          Expanded(flex: 1, child: Text('Status', style: style)),
          Expanded(flex: 1, child: Text('Actions', style: style)),
        ],
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isTablet;
  final AdminController controller;

  const _TableRow({
    required this.data,
    required this.isTablet,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isCreator = data['Type'] == 'Creator';

    return InkWell(
      onTap: () => _showApplicationDetail(context, data, data['id'], controller),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[50]!)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  _Avatar(
                      name: data['fullName'] ?? 'U', isCreator: isCreator),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['fullName'] ?? 'Unknown',
                          style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1A2E)),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (data['submittedAt'] != null)
                          Text(
                            DateFormat('MMM d, yyyy').format(
                                (data['submittedAt'] as Timestamp).toDate()),
                            style: GoogleFonts.dmSans(
                                fontSize: 11, color: Colors.grey[400]),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!isTablet)
              Expanded(
                flex: 2,
                child: Text(
                  data['email'] ?? '',
                  style:
                      GoogleFonts.dmSans(fontSize: 13, color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            Expanded(flex: 1, child: _TypeBadge(type: data['Type'])),
            Expanded(
                flex: 1,
                child: _StatusChip(status: data['status'] ?? 'pending')),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => _showApplicationDetail(
                        context, data, data['id'], controller),
                    icon: const Icon(Icons.visibility_outlined, size: 18),
                    tooltip: 'View',
                    color: Colors.grey[500],
                  ),
                  IconButton(
                    onPressed: () => _confirmDelete(data['id']),
                    icon:
                        const Icon(Icons.delete_outline_rounded, size: 18),
                    tooltip: 'Delete',
                    color: Colors.red[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(String docId) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete Application',
            style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700)),
        content: Text('This action cannot be undone.',
            style: GoogleFonts.dmSans(color: Colors.grey[600])),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',
                style: GoogleFonts.dmSans(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.deleteApplication(docId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child:
                Text('Delete', style: GoogleFonts.dmSans(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  MOBILE APPLICATION CARD
// ═══════════════════════════════════════════════════════════════
class _ApplicationCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final AdminController controller;

  const _ApplicationCard({required this.data, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isCreator = data['Type'] == 'Creator';

    return InkWell(
      onTap: () =>
          _showApplicationDetail(context, data, data['id'], controller),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[100]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                _Avatar(
                    name: data['fullName'] ?? 'U',
                    isCreator: isCreator,
                    size: 44),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['fullName'] ?? 'Unknown',
                        style: GoogleFonts.spaceGrotesk(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        data['email'] ?? '',
                        style: GoogleFonts.dmSans(
                            fontSize: 12, color: Colors.grey[500]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert,
                      color: Colors.grey[400], size: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onSelected: (val) {
                    if (val == 'delete') {
                      controller.deleteApplication(data['id']);
                    } else {
                      controller.updateStatus(data['id'], val);
                    }
                  },
                  itemBuilder: (_) => [
                    if (data['status'] == 'pending') ...[
                      const PopupMenuItem(
                          value: 'approved', child: Text('Approve')),
                      const PopupMenuItem(
                          value: 'rejected', child: Text('Reject')),
                    ],
                    const PopupMenuItem(
                      value: 'delete',
                      child:
                          Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _TypeBadge(type: data['Type']),
                const SizedBox(width: 8),
                _StatusChip(status: data['status'] ?? 'pending'),
                const Spacer(),
                if (data['submittedAt'] != null)
                  Text(
                    DateFormat('MMM d').format(
                        (data['submittedAt'] as Timestamp).toDate()),
                    style: GoogleFonts.dmSans(
                        fontSize: 11, color: Colors.grey[400]),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SHARED WIDGETS
// ═══════════════════════════════════════════════════════════════
class _Avatar extends StatelessWidget {
  final String name;
  final bool isCreator;
  final double size;

  const _Avatar(
      {required this.name, required this.isCreator, this.size = 38});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isCreator
              ? [AppColors.accentMagenta, const Color(0xFFFF6B9D)]
              : [AppColors.accentCyan2, const Color(0xFF26d9d0)],
        ),
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Center(
        child: Text(
          name[0].toUpperCase(),
          style: GoogleFonts.spaceGrotesk(
            fontSize: size * 0.42,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String? type;
  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final isCreator = type == 'Creator';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isCreator
            ? AppColors.accentMagenta.withOpacity(0.1)
            : AppColors.accentCyan2.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type ?? 'N/A',
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isCreator ? AppColors.accentMagenta : AppColors.accentCyan2,
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    IconData icon;

    switch (status) {
      case 'approved':
        bgColor = const Color(0xFF00C853).withOpacity(0.12);
        textColor = const Color(0xFF00C853);
        icon = Icons.check_circle_outline_rounded;
        break;
      case 'rejected':
        bgColor = Colors.red.withOpacity(0.12);
        textColor = Colors.red;
        icon = Icons.cancel_outlined;
        break;
      default:
        bgColor = const Color(0xFFf5a623).withOpacity(0.12);
        textColor = const Color(0xFFf5a623);
        icon = Icons.schedule_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: textColor),
          const SizedBox(width: 4),
          Text(
            status[0].toUpperCase() + status.substring(1),
            style: GoogleFonts.dmSans(
                fontSize: 11, fontWeight: FontWeight.w600, color: textColor),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  APPLICATION DETAIL DIALOG
// ═══════════════════════════════════════════════════════════════
void _showApplicationDetail(
  BuildContext context,
  Map<String, dynamic> data,
  String docId,
  AdminController controller,
) {
  final isCreator = data['Type'] == 'Creator';

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.all(context.width < 800 ? 16 : 40),
      child: Container(
        width: context.width < 800 ? double.infinity : 550,
        constraints: const BoxConstraints(maxHeight: 650),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isCreator
                ? [const Color(0xFFFFF0F7), Colors.white]
                : [const Color(0xFFF0FFFE), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _Avatar(
                      name: data['fullName'] ?? 'U',
                      isCreator: isCreator,
                      size: 48),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['fullName'] ?? 'Unknown',
                          style: GoogleFonts.spaceGrotesk(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A2E)),
                        ),
                        const SizedBox(height: 4),
                        _StatusChip(status: data['status'] ?? 'pending'),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close_rounded, size: 22),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.grey[200]),
              const SizedBox(height: 20),
              _DetailRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: data['email']),
              if (isCreator) ...[
                _DetailRow(
                    icon: Icons.alternate_email,
                    label: 'TikTok',
                    value: data['tiktokHandle']),
                _DetailRow(
                    icon: Icons.people_outline,
                    label: 'Followers',
                    value: data['followerCount']),
                _DetailRow(
                    icon: Icons.category_outlined,
                    label: 'Niche',
                    value: data['contentNiche']),
                _DetailRow(
                    icon: Icons.info_outline,
                    label: 'Bio',
                    value: data['bio']),
              ] else ...[
                _DetailRow(
                    icon: Icons.business_outlined,
                    label: 'Company',
                    value: data['company']),
                _DetailRow(
                    icon: Icons.attach_money_rounded,
                    label: 'Budget',
                    value: data['budgetRange']),
                _DetailRow(
                    icon: Icons.flag_outlined,
                    label: 'Goal',
                    value: data['campaignGoal']),
                _DetailRow(
                    icon: Icons.description_outlined,
                    label: 'Project',
                    value: data['projectDescription']),
              ],
              if (data['submittedAt'] != null)
                _DetailRow(
                  icon: Icons.schedule_outlined,
                  label: 'Submitted',
                  value: DateFormat('MMM d, yyyy – h:mm a')
                      .format((data['submittedAt'] as Timestamp).toDate()),
                ),
              const SizedBox(height: 28),
              if (data['status'] == 'pending')
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.updateStatus(docId, 'approved');
                          Get.back();
                        },
                        icon: const Icon(Icons.check_rounded, size: 18),
                        label: Text('Approve',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C853),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.updateStatus(docId, 'rejected');
                          Get.back();
                        },
                        icon: const Icon(Icons.close_rounded, size: 18),
                        label: Text('Reject',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;

  const _DetailRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey[500]),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: const Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatData {
  final String label;
  final int count;
  final IconData icon;
  final List<Color> colors;
  _StatData(this.label, this.count, this.icon, this.colors);
}
