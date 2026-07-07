import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'bouncing_widget.dart';

class DashboardHeader extends StatelessWidget {
  final String title;

  const DashboardHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: AppColors.headerBg, // blends with page background
      child: Row(
        children: [
          if (MediaQuery.of(context).size.width < 700) ...[
            BouncingWidget(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(
                Icons.menu_rounded,
                color: Color(0xFF212036),
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
          ],
          // Title "Home"
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF8E92BC), // light gray/purple heading
            ),
          ),

          const Spacer(),

          // Search bar (Desktop) or Search Icon (Mobile)
          if (MediaQuery.of(context).size.width > 600)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.searchBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(bottom: 12),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.white.withValues(alpha: 0.6),
                      size: 18,
                    ),
                  ],
                ),
              ),
            )
          else
            BouncingWidget(
              onTap: () {},
              child: const Icon(
                Icons.search,
                color: Color(0xFF212036),
                size: 22,
              ),
            ),

          SizedBox(width: MediaQuery.of(context).size.width > 600 ? 65 : 14),

          // Icons
          BouncingWidget(
            onTap: () {},
            child: const _HeaderIcon(
              icon: Icons.assignment_outlined,
              badgeColor: Color(0xFF5B21B6),
              hasBadge: true,
            ),
          ),
          const SizedBox(width: 14),
          BouncingWidget(
            onTap: () {},
            child: const _HeaderIcon(
              icon: Icons.notifications_none_outlined,
              badgeColor: Color(0xFFF59E0B),
              hasBadge: true,
            ),
          ),
          const SizedBox(width: 14),
          BouncingWidget(
            onTap: () {},
            child: const Icon(
              Icons.power_settings_new_rounded,
              color: Color(0xFF212036),
              size: 22,
            ),
          ),
          
          SizedBox(width: MediaQuery.of(context).size.width > 600 ? 48 : 16),

          // User avatar
          BouncingWidget(
            onTap: () {},
            child: SizedBox(
              width: 38,
              height: 38,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2A2D54),
                    ),
                  ),
                  const Positioned(
                    top: -7,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        '🤠',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final Color badgeColor;
  final bool hasBadge;

  const _HeaderIcon({
    required this.icon,
    required this.badgeColor,
    required this.hasBadge,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: const Color(0xFF212036), size: 22),
        if (hasBadge)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
              ),
            ),
          ),
      ],
    );
  }
}
