import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/sidebar.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/hero_banner.dart';
import '../widgets/all_projects_widget.dart';
import '../widgets/top_creators_widget.dart';
import '../widgets/performance_chart.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/celebration_cards.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobileView = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: AppColors.mainBg,
      drawer: isMobileView
          ? Drawer(
              child: Sidebar(
                selectedIndex: _selectedNavIndex,
                onItemSelected: (index) {
                  setState(() => _selectedNavIndex = index);
                  Navigator.pop(context); // Close drawer on selection
                },
              ),
            )
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1100;
          final isTablet =
              constraints.maxWidth >= 700 && constraints.maxWidth < 1100;
          final isMobile = constraints.maxWidth < 700;

          if (isMobile) {
            return _buildMobileLayout();
          }

          return _buildDesktopLayout(
            showRightPanel: isDesktop,
            compactSidebar: isTablet,
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout({
    required bool showRightPanel,
    required bool compactSidebar,
  }) {
    return Row(
      children: [
        // Sidebar
        Sidebar(
          selectedIndex: _selectedNavIndex,
          onItemSelected: (index) => setState(() => _selectedNavIndex = index),
        ),

        // Main content
        Expanded(
          child: Column(
            children: [
              // Header
              const DashboardHeader(title: 'Home'),

              // Scrollable body
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const HeroBanner(),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(child: AllProjectsWidget()),
                                const SizedBox(width: 16),
                                const Expanded(child: TopCreatorsWidget()),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const PerformanceChart(),
                            const SizedBox(height: 20),
                            // If tablet view, show the right panel content at the bottom of the main view
                            if (!showRightPanel) ...[
                              const CalendarWidget(),
                              const SizedBox(height: 20),
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: BirthdayCard()),
                                  SizedBox(width: 16),
                                  Expanded(child: AnniversaryCard()),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ],
                        ),
                      ),
                    ),

                    // Right panel
                    if (showRightPanel) _buildRightPanel(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        const DashboardHeader(title: 'Home'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const HeroBanner(),
                const SizedBox(height: 16),
                const AllProjectsWidget(),
                const SizedBox(height: 16),
                const TopCreatorsWidget(),
                const SizedBox(height: 16),
                const PerformanceChart(),
                const SizedBox(height: 16),
                const CalendarWidget(),
                const SizedBox(height: 16),
                const BirthdayCard(),
                const SizedBox(height: 16),
                const AnniversaryCard(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        // Bottom nav for mobile
        _buildMobileBottomNav(),
      ],
    );
  }

  Widget _buildRightPanel() {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: AppColors.rightPanelBg,
        border: Border(left: BorderSide(color: Color(0xFF2D3060), width: 1)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CalendarWidget(),
            SizedBox(height: 8),
            BirthdayCard(),
            SizedBox(height: 8),
            AnniversaryCard(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileBottomNav() {
    final items = [
      (Icons.home_rounded, 'Home', 0),
      (Icons.people_alt_outlined, 'Employees', 1),
      (Icons.format_list_bulleted_rounded, 'Attendance', 2),
      (Icons.calendar_month_outlined, 'Summary', 3),
      (Icons.settings_outlined, 'Settings', 5),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items
                .map(
                  (item) => GestureDetector(
                    onTap: () => setState(() => _selectedNavIndex = item.$3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.$1,
                          size: 22,
                          color: _selectedNavIndex == item.$3
                              ? AppColors.primary
                              : AppColors.textMuted,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.$2,
                          style: TextStyle(
                            fontSize: 10,
                            color: _selectedNavIndex == item.$3
                                ? AppColors.primary
                                : AppColors.textMuted,
                            fontWeight: _selectedNavIndex == item.$3
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
