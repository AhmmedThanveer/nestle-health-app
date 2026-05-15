import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/agenda_models.dart';
import '../../../../core/theme/app_textstyles.dart';

/// A single session row: [time | topic | speaker] with an optional divider.
class SessionTileWidget extends StatelessWidget {
  final AgendaSession session;
  final bool isLast;

  const SessionTileWidget({
    super.key,
    required this.session,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Time column (start / end on two lines) ─────────────
              SizedBox(
                width: 72.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${session.startTime} -',
                      style: AppTextStyles.agendaSessionTime,
                    ),
                    Text(
                      session.endTime,
                      style: AppTextStyles.agendaSessionTime,
                    ),
                  ],
                ),
              ),

              // ── Topic ───────────────────────────────────────────────
              Expanded(
                child: Text(
                  session.topic,
                  style: AppTextStyles.agendaSessionTopic,
                ),
              ),

              SizedBox(width: 8.w),

              // ── Speaker (right-aligned, bold) ───────────────────────
              SizedBox(
                width: 110.w,
                child: Text(
                  session.speaker,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.agendaSessionSpeaker,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.agendaRowDivider,
          ),
      ],
    );
  }
}
