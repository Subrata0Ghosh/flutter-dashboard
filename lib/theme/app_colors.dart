import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF7C3AED);
  static const Color primaryLight = Color(0xFF9D5CF6);
  static const Color primaryDark = Color(0xFF5B21B6);

  // Sidebar
  static const Color sidebarBg = Color(0xFFFFFFFF);
  static const Color sidebarActive = Color(0xFFF1F5F9);
  static const Color sidebarText = Color(0xFF64748B);
  static const Color sidebarTextActive = Color(0xFF0F172A);
  static const Color sidebarDivider = Color(0xFFE2E8F0);

  // Main background
  static const Color mainBg = Color(0xFFF3F4F6);

  // Cards
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color darkCard = Color(0xFF1E1F3D); // Dark card matching PDF
  static const Color darkCardSecondary = Color(0xFF252849);

  // Right panel
  static const Color rightPanelBg = Color(
    0xFF1A1D3A,
  ); // Slightly darker for right panel
  static const Color rightPanelCard = Color(0xFF1E2041);

  // Accent colors
  static const Color red = Color(0xFFEF4444);
  static const Color pink = Color(0xFFEC4899);
  static const Color orange = Color(0xFFF97316);
  static const Color green = Color(0xFF10B981);
  static const Color blue = Color(0xFF3B82F6);
  static const Color indigo = Color(0xFF6366F1);
  static const Color yellow = Color(0xFFFBBF24);

  // Chart
  static const Color chartPending = Color(0xFFEC4899);
  static const Color chartDone = Color(0xFF6366F1);

  // Text
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF9CA3AF);

  // Header
  static const Color headerBg = Color(0xFFF3F4F6); // Header blends with mainBg
  static const Color searchBg = Color(
    0xFF2A2B4A,
  ); // Dark search field matching PDF
  static const Color searchBorder = Color(0xFF2A2B4A);

  // Banner gradient
  static const List<Color> bannerGradient = [
    Color(0xFF6432C9),
    Color(0xFF9B51E0),
  ];

  // Purple gradient button
  static const List<Color> purpleGradient = [
    Color(0xFF9B51E0),
    Color(0xFF6432C9),
  ];

  // Right panel accent
  static const Color accentPurple = Color(0xFF7C3AED);
  static const Color calendarHighlight = Color(0xFF7C3AED);
  static const Color todayHighlight = Color(0xFF7C3AED);
}
