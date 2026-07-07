import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'bouncing_widget.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _adstacksExpanded = true;
  bool _financeExpanded = false;

  final List<_NavItem> _navItems = [
    _NavItem(icon: Icons.home_rounded, label: 'Home', index: 0),
    _NavItem(icon: Icons.people_alt_outlined, label: 'Employees', index: 1),
    _NavItem(
      icon: Icons.format_list_bulleted_rounded,
      label: 'Attendance',
      index: 2,
    ),
    _NavItem(icon: Icons.calendar_month_outlined, label: 'Summary', index: 3),
    _NavItem(icon: Icons.info_outline_rounded, label: 'Information', index: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: const BoxDecoration(
        color: AppColors.sidebarBg,
        border: Border(right: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Center(
              child: Image.asset(
                'assets/images/logo.jpg',
                height: 76,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback if image fails to load
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppColors.purpleGradient,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'AS',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'AdStacks',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          const Divider(
            color: Color(0xFFE2E8F0),
            height: 1,
            indent: 24,
            endIndent: 24,
          ),

          // User Profile
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                // Avatar with gold ring
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFBBF24),
                      width: 2,
                    ), // Gold border matching PDF
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/memoji_girl.png',
                          ), // local asset fallback
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Pooja Mishra',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFF8B5CF6).withValues(alpha: 0.5),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Admin',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            color: Color(0xFFE2E8F0),
            height: 1,
            indent: 24,
            endIndent: 24,
          ),
          const SizedBox(height: 8),

          // Nav Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                ..._navItems.map((item) => _buildNavItem(item)),

                const SizedBox(height: 16),

                // Workspaces header card matching PDF (full-width light blue/purple background)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE6E6FA), // very light purple
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'WORKSPACES',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Icon(Icons.add, color: Colors.black, size: 20),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Adstacks workspace
                _buildWorkspaceItem('Adstacks', _adstacksExpanded, () {
                  setState(() => _adstacksExpanded = !_adstacksExpanded);
                }),

                // Finance workspace
                _buildWorkspaceItem('Finance', _financeExpanded, () {
                  setState(() => _financeExpanded = !_financeExpanded);
                }),

                const SizedBox(height: 16),
              ],
            ),
          ),

          // Removed divider above settings
          // Bottom items
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                _buildBottomNavItem(Icons.settings_outlined, 'Setting', 5),
                const SizedBox(height: 8),
                _buildBottomNavItem(Icons.logout_rounded, 'Logout', 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(_NavItem item) {
    final bool isActive = widget.selectedIndex == item.index;
    return BouncingWidget(
      onTap: () => widget.onItemSelected(item.index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(
          left: 12,
          bottom: 1,
        ), // Reduced bottom margin
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ), // Reduced vertical padding
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFF3F4F6)
              : Colors.transparent, // very light grey for active
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Icon(item.icon, size: 22, color: Colors.black87),
            const SizedBox(width: 20),
            Text(
              item.label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkspaceItem(String name, bool expanded, VoidCallback onTap) {
    return BouncingWidget(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            Icon(
              expanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    final bool isActive = widget.selectedIndex == index;
    return BouncingWidget(
      onTap: () => widget.onItemSelected(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: isActive
                  ? AppColors.sidebarTextActive
                  : AppColors.sidebarText,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive
                    ? AppColors.sidebarTextActive
                    : AppColors.sidebarText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final int index;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
  });
}
