import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class AppTextStyles {
  // ── Brand / Logo ──────────────────────────────────────────────

  /// Montserrat ExtraBold – "NESTLÉ CONGRESS"
  static TextStyle logoTitle = TextStyle(
    fontSize: 31.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    fontFamily: 'Montserrat',
    letterSpacing: 1.2,
  );

  /// Bromello – "The Next Era of Nutrition & Health"
  static TextStyle logoSubtitle = TextStyle(
    fontSize: 22.sp,
    color: AppColors.white,
    fontFamily: 'Bromello',
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

  // ── Form ──────────────────────────────────────────────────────

  static TextStyle labelStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  static TextStyle hintStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    color: const Color.fromARGB(255, 255, 253, 253),
    fontFamily: 'Roboto',
  );

  static TextStyle buttonStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  // ── Home / Dashboard ──────────────────────────────────────────

  /// Label under each home module card
  static TextStyle moduleLabel = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: 'Roboto',
    height: 1.3,
  );

  // ── Bottom Navigation ─────────────────────────────────────────

  /// Selected nav item label (inside white chip)
  static TextStyle navLabelSelected = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.navSelectedContent,
    fontFamily: 'Roboto',
    letterSpacing: 0.2,
  );

  /// Unselected nav item label
  static TextStyle navLabelUnselected = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.navUnselected,
    fontFamily: 'Roboto',
  );

  // ── Section / Screen Titles ───────────────────────────────────

  static TextStyle sectionTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  static TextStyle bodyWhite = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
    height: 1.5,
  );

  // ── Module App Bar ────────────────────────────────────────────

  /// Module screen title next to the back button (e.g. "Agenda")
  static TextStyle moduleScreenTitle = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  // ── Agenda ────────────────────────────────────────────────────

  /// Selected day tab label
  static TextStyle agendaDayTabSelected = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryBlue,
    fontFamily: 'Roboto',
  );

  /// Unselected day tab label
  static TextStyle agendaDayTabUnselected = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// Hall / moderator banner text
  static TextStyle agendaBannerText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// Hall name in the dropdown pill (primaryBlue, bold)
  static TextStyle agendaHallDropdown = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryBlue,
    fontFamily: 'Roboto',
  );

  /// "Time / Topic / Speakers" table-header row
  static TextStyle agendaTableHeader = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// Session time (muted, two-line start–end)
  static TextStyle agendaSessionTime = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xB3FFFFFF), // white 70%
    fontFamily: 'Roboto',
    height: 1.5,
  );

  /// Session topic
  static TextStyle agendaSessionTopic = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
    height: 1.45,
  );

  /// Session speaker (bold, right-aligned)
  static TextStyle agendaSessionSpeaker = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
    height: 1.45,
  );

  /// Hall picker sheet title ("Select Hall")
  static TextStyle agendaPickerTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// Hall option in picker sheet
  static TextStyle agendaPickerOption = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// Selected hall option in picker sheet
  static TextStyle agendaPickerOptionSelected = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );
}
