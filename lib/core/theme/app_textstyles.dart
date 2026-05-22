import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class AppTextStyles {
  // â”€â”€ Brand / Logo â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Montserrat ExtraBold â€“ "NESTLÃ‰ CONGRESS"
  static TextStyle logoTitle = TextStyle(
    fontSize: 31.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    fontFamily: 'Montserrat',
    letterSpacing: 1.2,
  );

  /// Bromello â€“ "The Next Era of Nutrition & Health"
  static TextStyle logoSubtitle = TextStyle(
    fontSize: 22.sp,
    color: AppColors.white,
    fontFamily: 'Bromello',
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

  // â”€â”€ Form â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  static TextStyle labelStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  static TextStyle hintStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    color: const Color.fromARGB(255, 255, 253, 253),
    fontFamily: 'Montserrat',
  );

  static TextStyle buttonStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  // â”€â”€ Home / Dashboard â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Label under each home module card
  static TextStyle moduleLabel = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: 'Montserrat',
    height: 1.3,
  );

  // â”€â”€ Bottom Navigation â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Selected nav item label (inside white chip)
  static TextStyle navLabelSelected = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.navSelectedContent,
    fontFamily: 'Montserrat',
    letterSpacing: 0.2,
  );

  /// Unselected nav item label
  static TextStyle navLabelUnselected = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.navUnselected,
    fontFamily: 'Montserrat',
  );

  // â”€â”€ Section / Screen Titles â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  static TextStyle sectionTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  static TextStyle bodyWhite = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
    height: 1.5,
  );

  // â”€â”€ Module App Bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Module screen title next to the back button (e.g. "Agenda")
  static TextStyle moduleScreenTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  // â”€â”€ Agenda â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Selected day tab label
  static TextStyle agendaDayTabSelected = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryBlue,
    fontFamily: 'Montserrat',
  );

  /// Unselected day tab label
  static TextStyle agendaDayTabUnselected = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// Hall / moderator banner text
  static TextStyle agendaBannerText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// Hall name in the dropdown pill (primaryBlue, bold)
  static TextStyle agendaHallDropdown = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryBlue,
    fontFamily: 'Montserrat',
  );

  /// "Time / Topic / Speakers" table-header row
  static TextStyle agendaTableHeader = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// Session time (muted, two-line startâ€“end)
  static TextStyle agendaSessionTime = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white70,
    fontFamily: 'Montserrat',
    height: 1.5,
  );

  /// Session topic
  static TextStyle agendaSessionTopic = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
    height: 1.45,
  );

  /// Session speaker (bold, right-aligned)
  static TextStyle agendaSessionSpeaker = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
    height: 1.45,
  );

  /// Hall picker sheet title ("Select Hall")
  static TextStyle agendaPickerTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// Hall option in picker sheet
  static TextStyle agendaPickerOption = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// Selected hall option in picker sheet
  static TextStyle agendaPickerOptionSelected = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  // â”€â”€ Speakers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Selected category tab label (bold white)
  static TextStyle speakerCategoryTabSelected = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// Unselected category tab label
  static TextStyle speakerCategoryTabUnselected = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// Speaker name in list tile (bold white)
  static TextStyle speakerName = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// "Name" / "Bio" muted labels on detail card
  static TextStyle speakerDetailLabel = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.speakerLabelColor,
    fontFamily: 'Montserrat',
  );

  /// Speaker name and bio body text on detail card
  static TextStyle speakerDetailValue = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
    height: 1.55,
  );

  // â”€â”€ Media (Photos & Videos) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Selected media tab label (bold white)
  static TextStyle mediaTabSelected = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// Unselected media tab label
  static TextStyle mediaTabUnselected = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// "Play" / "View" action label on media cards
  static TextStyle mediaCardAction = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  // â”€â”€ Assets â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Muted folder name in the card's top area
  static TextStyle assetFolderName = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white70,
    fontFamily: 'Montserrat',
  );

  /// Bold folder name in the card's dark bottom bar
  static TextStyle assetFolderCardName = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// "View Assets" action label in folder card bottom bar
  static TextStyle viewAssetsText = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// File name in asset file list tile
  static TextStyle assetFileName = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// File size / secondary info in asset file tile
  static TextStyle assetFileSize = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.speakerLabelColor,
    fontFamily: 'Montserrat',
  );

  /// "X file(s)" count label above the file list
  static TextStyle fileCountLabel = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.speakerLabelColor,
    fontFamily: 'Montserrat',
  );

  /// PDF viewer top-bar title ("Page X of Y")
  static TextStyle pdfViewerHeader = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// PDF viewer bottom-bar pagination ("X / Y")
  static TextStyle pdfViewerPageNav = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  // â”€â”€ Stations â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Bold ALL-CAPS station name in the list tile
  static TextStyle stationName = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Montserrat',
    letterSpacing: 0.5,
  );

  /// "50 points" text beside the star icon
  static TextStyle stationPoints = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// "Scan" text inside the scan pill button
  static TextStyle scanButtonText = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// "Scan QR Code" title in the scanner bottom sheet
  static TextStyle scanQrTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// Station name in cyan shown below the QR sheet title
  static TextStyle scanQrStation = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.scannerStationCyan,
    fontFamily: 'Montserrat',
  );

  /// Instruction text at the bottom of the QR scanner sheet
  static TextStyle scanQrInstruction = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white70,
    fontFamily: 'Montserrat',
    height: 1.4,
  );

  /// "Scan Failed" bold title in the failure dialog
  static TextStyle scanFailedTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    fontFamily: 'Montserrat',
  );

  /// Gray subtitle in the scan-failed dialog
  static TextStyle scanFailedSubtitle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.subtleText,
    fontFamily: 'Montserrat',
    height: 1.45,
  );

  /// "Done" button text in the scan-failed dialog
  static TextStyle scanFailedButton = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  // â”€â”€ NSM â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// "Day N" inside the white selected pill
  static TextStyle nsmDayLabel = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryBlue,
    fontFamily: 'Montserrat',
  );

  /// Date text on the right of the day header pill
  static TextStyle nsmDateLabel = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  /// Wave card title (e.g. "1st wave : Move from Ritz Carlton")
  static TextStyle nsmWaveTitle = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white80,
    fontFamily: 'Montserrat',
    height: 1.4,
  );

  /// Time / capacity info rows on wave card
  static TextStyle nsmWaveInfo = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white70,
    fontFamily: 'Montserrat',
  );

  /// "FULL" badge text
  static TextStyle nsmFullBadge = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
    letterSpacing: 0.5,
  );

  // â”€â”€ Venue â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// "Location" / "About the Venue" card section title
  static TextStyle venueSectionTitle = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    fontFamily: 'Montserrat',
  );

  /// Bold hotel name "RITZ CARLTON JEDDAH"
  static TextStyle venueHotelName = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
    fontFamily: 'Montserrat',
  );

  /// Address, city, hall â€” regular info text in venue card
  static TextStyle venueInfoText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.bodyText,
    fontFamily: 'Montserrat',
    height: 1.5,
  );

  /// "Open in Google Maps" button label
  static TextStyle openMapsText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlue,
    fontFamily: 'Montserrat',
  );

  // â”€â”€ Ask Question â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Form field label ("Your Name", "Speaker", "Ask Question")
  static TextStyle aqFieldLabel = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );
}
