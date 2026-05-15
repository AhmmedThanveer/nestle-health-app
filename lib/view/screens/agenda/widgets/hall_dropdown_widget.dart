import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/agenda_models.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../../view%20model/bloc/agenda/agenda_bloc.dart';

/// White pill that shows the current hall name and opens a bottom-sheet
/// picker when tapped. Shown only when a day has more than one hall.
class HallDropdownWidget extends StatelessWidget {
  final AgendaState state;

  const HallDropdownWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final AgendaHall hall = state.currentHall;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: () => _showPicker(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hall.fullName,
                  style: AppTextStyles.agendaHallDropdown,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.primaryBlue,
                size: 22.r,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<AgendaBloc>(),
        child: HallPickerSheet(
          halls: state.currentDay.halls,
          selectedIndex: state.selectedHall,
        ),
      ),
    );
  }
}

// ─── Hall picker bottom sheet ─────────────────────────────────────────────────

class HallPickerSheet extends StatelessWidget {
  final List<AgendaHall> halls;
  final int selectedIndex;

  const HallPickerSheet({
    super.key,
    required this.halls,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkNavy,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.glassBorder,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Text('Select Hall', style: AppTextStyles.agendaPickerTitle),
          SizedBox(height: 12.h),

          ...List.generate(halls.length, (i) {
            final bool selected = i == selectedIndex;
            return GestureDetector(
              onTap: () {
                context.read<AgendaBloc>().add(SelectHallEvent(i));
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primaryBlue.withValues(alpha: 0.35)
                      : AppColors.glassBg,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: selected
                        ? AppColors.cyan.withValues(alpha: 0.5)
                        : AppColors.glassBorder,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        halls[i].fullName,
                        style: selected
                            ? AppTextStyles.agendaPickerOptionSelected
                            : AppTextStyles.agendaPickerOption,
                      ),
                    ),
                    if (selected)
                      Icon(Icons.check_circle_rounded,
                          color: AppColors.cyan, size: 20.r),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
