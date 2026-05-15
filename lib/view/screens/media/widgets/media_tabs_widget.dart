import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/media_models.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../../view%20model/bloc/media/media_bloc.dart';
import '../../../../view%20model/bloc/media/media_event.dart';
import '../../../../view%20model/bloc/media/media_state.dart';

/// "Photos" / "Videos" animated pill tabs.
class MediaTabsWidget extends StatelessWidget {
  final MediaState state;

  const MediaTabsWidget({super.key, required this.state});

  static const _labels = [AppStrings.photos, AppStrings.videos];
  static const _types = [MediaType.photo, MediaType.video];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: List.generate(_types.length, (i) {
          final bool selected = state.selectedType == _types[i];
          return Expanded(
            child: GestureDetector(
              onTap: () => context
                  .read<MediaBloc>()
                  .add(SelectMediaTypeEvent(_types[i])),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                margin: EdgeInsets.only(
                  right: i == 0 ? 10.w : 0,
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.lightBlue
                      : AppColors.mediaTabUnselectedBg,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  _labels[i],
                  textAlign: TextAlign.center,
                  style: selected
                      ? AppTextStyles.mediaTabSelected
                      : AppTextStyles.mediaTabUnselected,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
