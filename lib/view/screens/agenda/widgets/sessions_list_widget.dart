import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/agenda_models.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../../view%20model/bloc/agenda/agenda_bloc.dart';
import '../../../widgets/animated_entrance_item.dart';
import 'session_tile_widget.dart';

/// Scrollable list: [hall banner?] + moderator banner + table header + session rows.
class SessionsListWidget extends StatelessWidget {
  final AgendaState state;

  const SessionsListWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final AgendaHall? hall = state.currentHall;
    if (hall == null) return const SizedBox.shrink();
    final bool singleHall = (state.currentDay?.halls.length ?? 1) == 1;
    final double bottomPad = 80.h + MediaQuery.of(context).padding.bottom;

    // index 0 → hall banner (single-hall days only)
    // index 1 (or 0) → moderators banner
    // index 2 (or 1) → table header
    // remaining → session rows
    final int headerCount = singleHall ? 3 : 2;

    return ListView.builder(
      padding: EdgeInsets.only(bottom: bottomPad),
      itemCount: hall.sessions.length + headerCount,
      itemBuilder: (context, index) {
        if (singleHall) {
          if (index == 0) return _HallBanner(name: hall.fullName);
          if (index == 1) return _ModeratorBanner(names: hall.moderators);
          if (index == 2) return const _TableHeader();
          final sessionIndex = index - 3;
          return AnimatedEntranceItem(
            direction: EntranceDirection.ttb,
            index: sessionIndex,
            child: SessionTileWidget(
              session: hall.sessions[sessionIndex],
              isLast: index == hall.sessions.length + 2,
            ),
          );
        } else {
          if (index == 0) return _ModeratorBanner(names: hall.moderators);
          if (index == 1) return const _TableHeader();
          final sessionIndex = index - 2;
          return AnimatedEntranceItem(
            direction: EntranceDirection.ttb,
            index: sessionIndex,
            child: SessionTileWidget(
              session: hall.sessions[sessionIndex],
              isLast: index == hall.sessions.length + 1,
            ),
          );
        }
      },
    );
  }
}

// ─── Hall banner (single-hall days) ──────────────────────────────────────────

class _HallBanner extends StatelessWidget {
  final String name;

  const _HallBanner({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.agendaHallBg,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: AppTextStyles.agendaBannerText,
      ),
    );
  }
}

// ─── Moderator banner ─────────────────────────────────────────────────────────

class _ModeratorBanner extends StatelessWidget {
  final String names;

  const _ModeratorBanner({required this.names});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.agendaModeratorBg,
      padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 16.w),
      child: Text(
        names,
        textAlign: TextAlign.center,
        style: AppTextStyles.agendaBannerText,
      ),
    );
  }
}

// ─── Table header row ─────────────────────────────────────────────────────────

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.agendaTableHeaderBg,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
            width: 72.w,
            child: Text('Time', style: AppTextStyles.agendaTableHeader),
          ),
          Expanded(
            child: Text('Topic', style: AppTextStyles.agendaTableHeader),
          ),
          SizedBox(
            width: 110.w,
            child: Text(
              'Speakers',
              textAlign: TextAlign.right,
              style: AppTextStyles.agendaTableHeader,
            ),
          ),
        ],
      ),
    );
  }
}
