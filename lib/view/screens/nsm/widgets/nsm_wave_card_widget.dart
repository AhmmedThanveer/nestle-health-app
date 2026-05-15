import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/nsm_models.dart';
import '../../../../core/theme/app_textstyles.dart';

class NsmWaveCardWidget extends StatelessWidget {
  final NsmWave wave;

  const NsmWaveCardWidget({super.key, required this.wave});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.nsmCardBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.nsmCardBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row with optional FULL badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(wave.title, style: AppTextStyles.nsmWaveTitle),
              ),
              if (wave.isFull) ...[SizedBox(width: 8.w), _FullBadge()],
            ],
          ),
          SizedBox(height: 10.h),

          // Time row
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                color: Colors.white70,
                size: 16.r,
              ),
              SizedBox(width: 6.w),
              Text(wave.time, style: AppTextStyles.nsmWaveInfo),
            ],
          ),
          SizedBox(height: 5.h),

          // Capacity row
          Row(
            children: [
              Icon(
                Icons.people_outline_rounded,
                color: Colors.white70,
                size: 16.r,
              ),
              SizedBox(width: 6.w),
              Text(wave.capacityLabel, style: AppTextStyles.nsmWaveInfo),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── FULL badge ───────────────────────────────────────────────────────────────

class _FullBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 85, 84, 84),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(AppStrings.nsmFull, style: AppTextStyles.nsmFullBadge),
    );
  }
}
