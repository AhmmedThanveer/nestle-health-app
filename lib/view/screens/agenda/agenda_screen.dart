import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../view%20model/bloc/agenda/agenda_bloc.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/day_tabs_widget.dart';
import 'widgets/hall_dropdown_widget.dart';
import 'widgets/sessions_list_widget.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AgendaBloc(),
      child: const _AgendaView(),
    );
  }
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _AgendaView extends StatelessWidget {
  const _AgendaView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
      listener: (_, __) => Navigator.maybePop(context),
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.primaryBlue,
        bottomNavigationBar: const NestleBottomNavigationBar(),
        body: Stack(
          children: [
            // ── Background image ──────────────────────────────────
            Positioned.fill(
              child: Image.asset(
                AppImages.loginBg,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                filterQuality: FilterQuality.low,
              ),
            ),

            // ── Gradient overlay ──────────────────────────────────
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.35, 0.62, 1.0],
                    colors: [
                      AppColors.primaryBlue.withValues(alpha: 1.0),
                      AppColors.primaryBlue.withValues(alpha: 0.95),
                      AppColors.primaryBlue.withValues(alpha: 0.75),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // ── Content ───────────────────────────────────────────
            SafeArea(
              bottom: false,
              child: BlocBuilder<AgendaBloc, AgendaState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ModuleAppBar(title: AppStrings.agenda),
                      SizedBox(height: 4.h),

                      NestleLogoWidget(topPadding: 0),
                      SizedBox(height: 14.h),

                      DayTabsWidget(state: state),
                      SizedBox(height: 20.h),

                      if (state.currentDay.halls.length > 1) ...[
                        HallDropdownWidget(state: state),
                        SizedBox(height: 40.h),
                      ],

                      Expanded(
                        child: RepaintBoundary(
                          child: SessionsListWidget(state: state),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
