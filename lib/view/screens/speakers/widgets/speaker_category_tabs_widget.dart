import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/speaker_models.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../../view%20model/bloc/speakers/speakers_bloc.dart';
import '../../../../view%20model/bloc/speakers/speakers_event.dart';
import '../../../../view%20model/bloc/speakers/speakers_state.dart';

/// Three animated pill tabs — one per speaker category.
class SpeakerCategoryTabsWidget extends StatelessWidget {
  final SpeakersState state;

  const SpeakerCategoryTabsWidget({super.key, required this.state});

  static const _labels = [
    AppStrings.chairpersons,
    AppStrings.speakersCategory,
    AppStrings.nestleSpeakers,
  ];
  static const _categories = [
    SpeakerCategory.chairpersons,
    SpeakerCategory.speakers,
    SpeakerCategory.nestleSpeakers,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: List.generate(_categories.length, (i) {
          final bool selected = state.selectedCategory == _categories[i];
          return Expanded(
            child: GestureDetector(
              onTap: () => context
                  .read<SpeakersBloc>()
                  .add(SelectSpeakerCategoryEvent(_categories[i])),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                margin: EdgeInsets.only(
                  right: i < _categories.length - 1 ? 8.w : 0,
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.lightBlue
                      : AppColors.mediaTabUnselectedBg,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  _labels[i],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: selected
                      ? AppTextStyles.speakerCategoryTabSelected
                      : AppTextStyles.speakerCategoryTabUnselected,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
