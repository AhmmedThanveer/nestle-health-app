import 'package:flutter/material.dart';

class AppColors {
  // ── Auth / Brand ──────────────────────────────────────────────
  static const Color primaryBlue = Color(0xFF005EA8);
  static const Color lightBlue = Color(0xFF4D9DE0);
  static const Color white = Colors.white;
  static const Color borderColor = Color(0xFFE4E4E4);
  static const Color textWhite = Colors.white;
  static const Color hintColor = Color(0xFFE0E0E0);
  static const Color transparent = Colors.transparent;

  // ── Home / Dashboard ──────────────────────────────────────────
  /// Bright teal used for circular module card borders
  static const Color cyan = Color(0xFF00C8E8);

  /// Darker teal variant for subtle accents
  static const Color cyanDark = Color(0xFF0098B8);

  /// Dark navy for bottom nav background
  static const Color darkNavy = Color(0xFF001533);

  /// White at 7% opacity – glass card background
  static const Color glassBg = Color(0x12FFFFFF);

  /// White at 20% opacity – glass card border
  static const Color glassBorder = Color(0x33FFFFFF);

  /// Cyan at 35% opacity – module circle border overlay
  static const Color cyanBorder = Color(0x59C0F0FF);

  // ── Agenda ────────────────────────────────────────────────────
  /// Hall / venue banner row background
  static const Color agendaHallBg = Color(0xFF1E7EC8);

  /// Moderator banner row background
  static const Color agendaModeratorBg = Color(0xFF1A6DB8);

  /// "Time / Topic / Speakers" table-header row background
  static const Color agendaTableHeaderBg = Color(0xFF1460A8);

  /// Thin divider between session rows (white 20%)
  static const Color agendaRowDivider = Color(0x33FFFFFF);

  /// Unselected day-tab background (white 18%)
  static const Color agendaTabUnselectedBg = Color(0x2EFFFFFF);

  // ── Bottom Navigation ─────────────────────────────────────────
  /// Dark navy with 85% opacity – nav bar background
  static const Color bottomNavBg = Color(0xD9001533);

  /// White 15% border on nav bar
  static const Color navBorder = Color(0x26FFFFFF);

  /// Dark primary used as icon color in selected nav chip
  static const Color navSelectedContent = Color(0xFF003D7A);

  /// Muted white for unselected nav items
  static const Color navUnselected = Color(0xB3FFFFFF);
}
