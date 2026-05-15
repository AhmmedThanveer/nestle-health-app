import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/asset_models.dart';
import '../../../../core/theme/app_textstyles.dart';

/// Folder card in the 2-column assets grid.
/// Top area: translucent blue + archive icon.
/// Bottom bar: dark navy + bold name + "View Assets".
class AssetFolderCardWidget extends StatelessWidget {
  final AssetFolder folder;
  final VoidCallback onTap;

  const AssetFolderCardWidget({
    super.key,
    required this.folder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          children: [
            // ── Top area: icon + muted name ───────────────────
            Expanded(
              flex: 3,
              child: Container(
                color: AppColors.assetFolderCardBg,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.assetIconColor,
                      size: 46.r,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      folder.name,
                      style: AppTextStyles.assetFolderName,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom bar: bold name + "View Assets" ─────────
            Container(
              color: AppColors.assetFolderCardBottomBg,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    folder.name,
                    style: AppTextStyles.assetFolderCardName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_file_rounded,
                        color: AppColors.white,
                        size: 13.r,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        AppStrings.viewAssets,
                        style: AppTextStyles.viewAssetsText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
