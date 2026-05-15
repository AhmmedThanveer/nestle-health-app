import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../../view%20model/bloc/agenda/agenda_bloc.dart';

/// Horizontal row of animated pill tabs — one per day.
///
/// Selected day: white background + [AppColors.primaryBlue] text.
/// Unselected day: [AppColors.agendaTabUnselectedBg] + white text.
class DayTabsWidget extends StatelessWidget {
  final AgendaState state;

  const DayTabsWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: List.generate(state.days.length, (i) {
          final bool selected = i == state.selectedDay;
          final day = state.days[i];

          return Expanded(
            child: GestureDetector(
              onTap: () =>
                  context.read<AgendaBloc>().add(SelectDayEvent(i)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
                margin: EdgeInsets.only(
                  right: i < state.days.length - 1 ? 8.w : 0,
                ),
                padding: EdgeInsets.symmetric(vertical: 13.h),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.white
                      : AppColors.agendaTabUnselectedBg,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  '${day.label} (${day.date})',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: selected
                      ? AppTextStyles.agendaDayTabSelected
                      : AppTextStyles.agendaDayTabUnselected,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
