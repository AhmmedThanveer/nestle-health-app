import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../../domain/entities/station_entity.dart';
import '../../../widgets/animated_entrance_item.dart';

class StationListTileWidget extends StatelessWidget {
  final StationEntity station;
  final bool isScanned;
  final VoidCallback onScan;
  final int index;

  const StationListTileWidget({
    super.key,
    required this.station,
    required this.isScanned,
    required this.onScan,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedEntranceItem(
      direction: EntranceDirection.rtl,
      index: index,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.stationCardBg,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 50.r,
              height: 50.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.stationIconBg,
              ),
              child: Icon(
                Icons.location_on_rounded,
                color: AppColors.white,
                size: 26.r,
              ),
            ),
            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(station.name, style: AppTextStyles.stationName),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: AppColors.pointsGold,
                        size: 16.r,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${station.points} ${AppStrings.points}',
                        style: AppTextStyles.stationPoints,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),

            isScanned ? const _ScannedBadge() : _ScanButton(onScan: onScan),
          ],
        ),
      ),
    );
  }
}

class _ScanButton extends StatelessWidget {
  final VoidCallback onScan;

  const _ScanButton({required this.onScan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScan,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: AppColors.lightBlue.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner_rounded, color: AppColors.white, size: 16.r),
            SizedBox(width: 5.w),
            Text(AppStrings.scan, style: AppTextStyles.scanButtonText),
          ],
        ),
      ),
    );
  }
}

class _ScannedBadge extends StatelessWidget {
  const _ScannedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: AppColors.stationScannedGreen,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline_rounded, color: AppColors.white, size: 16.r),
          SizedBox(width: 5.w),
          Text(AppStrings.scanned, style: AppTextStyles.scanButtonText),
        ],
      ),
    );
  }
}
