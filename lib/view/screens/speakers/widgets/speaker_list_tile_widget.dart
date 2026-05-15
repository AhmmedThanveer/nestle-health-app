import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/speaker_models.dart';
import '../../../../core/theme/app_textstyles.dart';

/// Single row in the speakers list — avatar + name + chevron.
class SpeakerListTileWidget extends StatelessWidget {
  final Speaker speaker;
  final bool isLast;
  final VoidCallback onTap;

  const SpeakerListTileWidget({
    super.key,
    required this.speaker,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          splashColor: AppColors.glassBg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Row(
              children: [
                // ── Circular avatar with blue ring ────────────────
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.lightBlue,
                      width: 2.5.r,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 34.r,
                    backgroundColor: AppColors.glassBg,
                    backgroundImage: NetworkImage(speaker.imageUrl),
                    onBackgroundImageError: (_, __) {},
                  ),
                ),
                SizedBox(width: 16.w),

                // ── Name ──────────────────────────────────────────
                Expanded(
                  child: Text(
                    speaker.name,
                    style: AppTextStyles.speakerName,
                  ),
                ),

                // ── Chevron ───────────────────────────────────────
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.white,
                  size: 26.r,
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 1,
            indent: 20.w,
            endIndent: 20.w,
            color: AppColors.glassBorder,
          ),
      ],
    );
  }
}
