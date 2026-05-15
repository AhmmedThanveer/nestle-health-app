import 'package:flutter/material.dart';

import '../constants/app_svg_icons.dart';
import '../constants/app_strings.dart';

/// Immutable data descriptor for a home dashboard module card.
class HomeModuleData {
  final String label;
  final String svgPath;
  final IconData fallbackIcon;
  final String route;

  const HomeModuleData({
    required this.label,
    required this.svgPath,
    required this.fallbackIcon,
    required this.route,
  });

  /// The full ordered list of 12 dashboard modules.
  static const List<HomeModuleData> all = [
    HomeModuleData(
      label: AppStrings.agenda,
      svgPath: AppSvgIcons.agenda,
      fallbackIcon: Icons.calendar_month_outlined,
      route: '/agenda',
    ),
    HomeModuleData(
      label: AppStrings.speakers,
      svgPath: AppSvgIcons.speakers,
      fallbackIcon: Icons.people_outline,
      route: '/speakers',
    ),
    HomeModuleData(
      label: AppStrings.nameTag,
      svgPath: AppSvgIcons.nameTag,
      fallbackIcon: Icons.badge_outlined,
      route: '/name-tag',
    ),
    HomeModuleData(
      label: AppStrings.voting,
      svgPath: AppSvgIcons.voting,
      fallbackIcon: Icons.how_to_vote_outlined,
      route: '/voting',
    ),
    HomeModuleData(
      label: AppStrings.venue,
      svgPath: AppSvgIcons.venue,
      fallbackIcon: Icons.location_on_outlined,
      route: '/venue',
    ),
    HomeModuleData(
      label: AppStrings.askQuestion,
      svgPath: AppSvgIcons.askQuestion,
      fallbackIcon: Icons.help_outline,
      route: '/ask-question',
    ),
    HomeModuleData(
      label: AppStrings.photosAndVideos,
      svgPath: AppSvgIcons.photosVideos,
      fallbackIcon: Icons.photo_camera_outlined,
      route: '/photos-videos',
    ),
    HomeModuleData(
      label: AppStrings.assets,
      svgPath: AppSvgIcons.assetsDownload,
      fallbackIcon: Icons.folder_zip_outlined,
      route: '/assets',
    ),
    HomeModuleData(
      label: AppStrings.claimYourCME,
      svgPath: AppSvgIcons.claimCme,
      fallbackIcon: Icons.workspace_premium_outlined,
      route: '/claim-cme',
    ),
    HomeModuleData(
      label: AppStrings.survey,
      svgPath: AppSvgIcons.survey,
      fallbackIcon: Icons.assignment_outlined,
      route: '/survey',
    ),
    HomeModuleData(
      label: AppStrings.stations,
      svgPath: AppSvgIcons.stations,
      fallbackIcon: Icons.store_outlined,
      route: '/stations',
    ),
    HomeModuleData(
      label: AppStrings.nsm,
      svgPath: AppSvgIcons.nsm,
      fallbackIcon: Icons.business_outlined,
      route: '/nsm',
    ),
  ];
}
