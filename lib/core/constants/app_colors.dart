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

  // ── Speakers ──────────────────────────────────────────────────
  /// Semi-transparent card background on speaker detail screen
  static const Color speakerDetailCardBg = Color(0x26FFFFFF);

  /// Muted white (60%) for detail card labels ("Name", "Bio")
  static const Color speakerLabelColor = Color(0x99FFFFFF);

  // ── Media (Photos & Videos) ───────────────────────────────────
  /// Unselected media tab pill background
  static const Color mediaTabUnselectedBg = Color(0xFF0A2854);

  /// Dark background for video cards (no thumbnail)
  static const Color videoCardBg = Color(0xFF0D2B4A);

  /// Dark overlay at the bottom of media cards ("Play" / "View" bar)
  static const Color mediaPlayBarBg = Color(0xCC000000);

  // ── Assets ────────────────────────────────────────────────────
  /// Top area of folder card (white 10%)
  static const Color assetFolderCardBg = Color(0x1AFFFFFF);

  /// Bottom bar of folder card – dark navy
  static const Color assetFolderCardBottomBg = Color(0xFF0A1E35);

  /// Background square for PDF/file type icon
  static const Color pdfIconBg = Color(0xFF2D7FC8);

  /// "PDF" badge background
  static const Color pdfBadgeBg = Color(0xFF3A9FE0);

  /// Muted icon color inside folder cards
  static const Color assetIconColor = Color(0x66FFFFFF);

  // ── NSM ───────────────────────────────────────────────────────
  /// Day-header pill container background (lighter blue)
  static const Color nsmDayPillBg = Color(0xFF1E7EC8);

  /// Wave card subtle background
  static const Color nsmCardBg = Color(0x1A1A4A8A);

  /// Golden amber border on wave cards
  static const Color nsmCardBorder = Color(0xFFCDA644);

  /// Dark badge background for the "FULL" label
  static const Color nsmFullBadgeBg = Color(0xFF404040);

  // ── Venue ──────────────────────────────────────────────────────
  /// Blue icon color used in venue info rows
  static const Color venueIconColor = Color(0xFF005EA8);

  // ── Stations ──────────────────────────────────────────────────
  /// Semi-transparent card background for station tiles
  static const Color stationCardBg = Color(0x1AFFFFFF);

  /// Circle icon background behind the location pin
  static const Color stationIconBg = Color(0x33FFFFFF);

  /// Gold/yellow for the star points icon
  static const Color pointsGold = Color(0xFFFFD700);

  /// Red background circle for the scan-failed "!" icon
  static const Color scanFailedRed = Color(0xFFE53935);

  /// Green for the "Scanned ✓" badge
  static const Color stationScannedGreen = Color(0xFF4CAF50);

  /// Cyan accent used for station name in QR scanner sheet
  static const Color scannerStationCyan = Color(0xFF00C8E8);

  /// Dark background for the QR scanner bottom sheet
  static const Color scannerSheetBg = Color(0xFF0D1B2A);

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
