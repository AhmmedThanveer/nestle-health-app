import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/asset_models.dart';
import '../../../../core/theme/app_textstyles.dart';

/// Single file row shown inside an asset folder screen.
class AssetFileTileWidget extends StatelessWidget {
  final AssetFile file;
  final VoidCallback onTap;

  const AssetFileTileWidget({
    super.key,
    required this.file,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.speakerDetailCardBg,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Row(
          children: [
            // ── File type icon square ─────────────────────────
            Container(
              width: 54.r,
              height: 54.r,
              decoration: BoxDecoration(
                color: AppColors.pdfIconBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.description_rounded,
                color: AppColors.white,
                size: 28.r,
              ),
            ),
            SizedBox(width: 14.w),

            // ── File info ─────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file.name,
                    style: AppTextStyles.assetFileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      // File type badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.pdfBadgeBg,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          file.fileType,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(file.fileSize, style: AppTextStyles.assetFileSize),
                    ],
                  ),
                ],
              ),
            ),

            // ── Chevron ───────────────────────────────────────
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.white,
              size: 22.r,
            ),
          ],
        ),
      ),
    );
  }
}
