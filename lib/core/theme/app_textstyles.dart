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
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
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

  // ── Speakers ──────────────────────────────────────────────────

  /// Selected category tab label (bold white)
  static TextStyle speakerCategoryTabSelected = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// Unselected category tab label
  static TextStyle speakerCategoryTabUnselected = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// Speaker name in list tile (bold white)
  static TextStyle speakerName = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// "Name" / "Bio" muted labels on detail card
  static TextStyle speakerDetailLabel = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.speakerLabelColor,
    fontFamily: 'Roboto',
  );

  /// Speaker name and bio body text on detail card
  static TextStyle speakerDetailValue = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
    height: 1.55,
  );

  // ── Media (Photos & Videos) ───────────────────────────────────

  /// Selected media tab label (bold white)
  static TextStyle mediaTabSelected = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// Unselected media tab label
  static TextStyle mediaTabUnselected = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// "Play" / "View" action label on media cards
  static TextStyle mediaCardAction = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  // ── Assets ────────────────────────────────────────────────────

  /// Muted folder name in the card's top area
  static TextStyle assetFolderName = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xB3FFFFFF),
    fontFamily: 'Roboto',
  );

  /// Bold folder name in the card's dark bottom bar
  static TextStyle assetFolderCardName = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// "View Assets" action label in folder card bottom bar
  static TextStyle viewAssetsText = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// File name in asset file list tile
  static TextStyle assetFileName = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// File size / secondary info in asset file tile
  static TextStyle assetFileSize = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.speakerLabelColor,
    fontFamily: 'Roboto',
  );

  /// "X file(s)" count label above the file list
  static TextStyle fileCountLabel = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.speakerLabelColor,
    fontFamily: 'Roboto',
  );

  /// PDF viewer top-bar title ("Page X of Y")
  static TextStyle pdfViewerHeader = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// PDF viewer bottom-bar pagination ("X / Y")
  static TextStyle pdfViewerPageNav = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  // ── Stations ──────────────────────────────────────────────────

  /// Bold ALL-CAPS station name in the list tile
  static TextStyle stationName = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
  );

  /// "50 points" text beside the star icon
  static TextStyle stationPoints = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// "Scan" text inside the scan pill button
  static TextStyle scanButtonText = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// "Scan QR Code" title in the scanner bottom sheet
  static TextStyle scanQrTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// Station name in cyan shown below the QR sheet title
  static TextStyle scanQrStation = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.scannerStationCyan,
    fontFamily: 'Roboto',
  );

  /// Instruction text at the bottom of the QR scanner sheet
  static TextStyle scanQrInstruction = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xB3FFFFFF),
    fontFamily: 'Roboto',
    height: 1.4,
  );

  /// "Scan Failed" bold title in the failure dialog
  static TextStyle scanFailedTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1A1A2E),
    fontFamily: 'Roboto',
  );

  /// Gray subtitle in the scan-failed dialog
  static TextStyle scanFailedSubtitle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xFF666666),
    fontFamily: 'Roboto',
    height: 1.45,
  );

  /// "Done" button text in the scan-failed dialog
  static TextStyle scanFailedButton = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  // ── NSM ───────────────────────────────────────────────────────

  /// "Day N" inside the white selected pill
  static TextStyle nsmDayLabel = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryBlue,
    fontFamily: 'Roboto',
  );

  /// Date text on the right of the day header pill
  static TextStyle nsmDateLabel = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );

  /// Wave card title (e.g. "1st wave : Move from Ritz Carlton")
  static TextStyle nsmWaveTitle = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: Color(0xCCFFFFFF),
    fontFamily: 'Roboto',
    height: 1.4,
  );

  /// Time / capacity info rows on wave card
  static TextStyle nsmWaveInfo = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xB3FFFFFF),
    fontFamily: 'Roboto',
  );

  /// "FULL" badge text
  static TextStyle nsmFullBadge = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
  );

  // ── Venue ──────────────────────────────────────────────────────

  /// "Location" / "About the Venue" card section title
  static TextStyle venueSectionTitle = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1A1A2E),
    fontFamily: 'Roboto',
  );

  /// Bold hotel name "RITZ CARLTON JEDDAH"
  static TextStyle venueHotelName = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1A1A2E),
    fontFamily: 'Roboto',
  );

  /// Address, city, hall — regular info text in venue card
  static TextStyle venueInfoText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xFF444444),
    fontFamily: 'Roboto',
    height: 1.5,
  );

  /// "Open in Google Maps" button label
  static TextStyle openMapsText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlue,
    fontFamily: 'Roboto',
  );

  // ── Ask Question ──────────────────────────────────────────────

  /// Form field label ("Your Name", "Speaker", "Ask Question")
  static TextStyle aqFieldLabel = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Roboto',
  );
}
