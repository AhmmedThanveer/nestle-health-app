import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/nsm_models.dart';
import '../../../../core/theme/app_textstyles.dart';

/// Blue pill showing "Day N" on the left and the full date on the right.
class NsmDayHeaderWidget extends StatelessWidget {
  final NsmDay day;

  const NsmDayHeaderWidget({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 10.h),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.nsmDayPillBg,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        children: [
          // White selected pill
          Container(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Text(
              '${AppStrings.nsmDay} ${day.dayNumber}',
              style: AppTextStyles.nsmDayLabel,
            ),
          ),
          SizedBox(width: 12.w),
          // Date text
          Expanded(
            child: Text(
              day.date,
              style: AppTextStyles.nsmDateLabel,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
