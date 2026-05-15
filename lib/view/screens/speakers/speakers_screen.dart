import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/session_store.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../../view%20model/bloc/profile/profile_bloc.dart';
import '../../../view%20model/bloc/speakers/speakers_bloc.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/speaker_category_tabs_widget.dart';
import 'widgets/speaker_list_widget.dart';

class SpeakersScreen extends StatelessWidget {
  const SpeakersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpeakersBloc(),
      child: const _SpeakersView(),
    );
  }
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _SpeakersView extends StatefulWidget {
  const _SpeakersView();

  @override
  State<_SpeakersView> createState() => _SpeakersViewState();
}

class _SpeakersViewState extends State<_SpeakersView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryLoad());
  }

  void _tryLoad() {
    if (!mounted) return;
    final profileState = context.read<ProfileBloc>().state;
    final eventId =
        profileState.user?.eventId ?? SessionStore.instance.pendingEventId;
    if (eventId != null && eventId.trim().isNotEmpty) {
      context.read<SpeakersBloc>().add(LoadSpeakersEvent(eventId.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (prev, curr) =>
          prev.user?.eventId == null && curr.user?.eventId != null,
      listener: (_, state) {
        final bloc = context.read<SpeakersBloc>();
        if (bloc.state.status == SpeakersStatus.initial) {
          bloc.add(LoadSpeakersEvent(state.user!.eventId!.trim()));
        }
      },
      child: BlocListener<NavigationBloc, NavigationState>(
        listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
        listener: (_, __) => Navigator.maybePop(context),
        child: Scaffold(
          extendBody: true,
          backgroundColor: AppColors.primaryBlue,
          bottomNavigationBar: const NestleBottomNavigationBar(),
          body: Stack(
            children: [
              // ── Background ──────────────────────────────────────
              Positioned.fill(
                child: Image.asset(
                  AppImages.loginBg,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  filterQuality: FilterQuality.low,
                ),
              ),
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

              // ── Content ─────────────────────────────────────────
              SafeArea(
                bottom: false,
                child: BlocBuilder<SpeakersBloc, SpeakersState>(
                  builder: (context, state) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ModuleAppBar(title: AppStrings.speakers),
                      SizedBox(height: 4.h),
                      NestleLogoWidget(topPadding: 0),
                      SizedBox(height: 20.h),

                      if (state.status == SpeakersStatus.loading)
                        const Expanded(child: _LoadingView()),

                      if (state.status == SpeakersStatus.error)
                        Expanded(child: _ErrorView(
                          message: state.errorMessage ?? 'Failed to load speakers',
                          onRetry: _tryLoad,
                        )),

                      if (state.status == SpeakersStatus.loaded) ...[
                        SpeakerCategoryTabsWidget(state: state),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: RepaintBoundary(
                            child: SpeakerListWidget(state: state),
                          ),
                        ),
                      ],

                      if (state.status == SpeakersStatus.initial)
                        const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Loading ──────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}

// ─── Error ────────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_outline_rounded,
                color: Colors.white54, size: 48.r),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Try Again',
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
