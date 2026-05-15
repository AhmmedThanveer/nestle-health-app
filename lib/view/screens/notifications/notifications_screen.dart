import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../view%20model/bloc/auth/auth_bloc.dart';
import '../../../view%20model/bloc/auth/auth_state.dart';
import '../../../view%20model/bloc/notification/notification_bloc.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/notification_card_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String? _watchedEventId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startWatching());
  }

  void _startWatching() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticatedState) {
      final eventId = authState.user.eventId;
      if (eventId != null && eventId != _watchedEventId) {
        _watchedEventId = eventId;
        context.read<NotificationBloc>().add(WatchNotificationsEvent(eventId));
      }
    }
  }

  Future<void> _onRefresh() async {
    _startWatching();
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        children: [
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
                  colors: [
                    AppColors.primaryBlue.withValues(alpha: 0.96),
                    AppColors.primaryBlue.withValues(alpha: 0.82),
                    AppColors.primaryBlue.withValues(alpha: 0.55),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: const NestleLogoWidget(),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: _NotificationsList(onRefresh: _onRefresh),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Notifications list ────────────────────────────────────────────────────────

class _NotificationsList extends StatelessWidget {
  final Future<void> Function() onRefresh;
  const _NotificationsList({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        border: Border.all(color: AppColors.glassBorder, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state.status == NotificationStatus.loading &&
                state.notifications.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            // RefreshIndicator requires a scrollable child — use CustomScrollView
            // with SliverFillRemaining so pull-to-refresh works on all states.
            return RefreshIndicator(
              onRefresh: onRefresh,
              color: AppColors.primaryBlue,
              backgroundColor: Colors.white,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  if (state.status == NotificationStatus.error &&
                      state.notifications.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Text(
                            state.errorMessage ??
                                'Failed to load notifications.',
                            style: AppTextStyles.bodyWhite,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  else if (state.notifications.isEmpty)
                    SliverFillRemaining(child: _EmptyNotifications())
                  else
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        14.w,
                        16.h,
                        14.w,
                        80.h + MediaQuery.of(context).padding.bottom,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => NotificationCardWidget(
                            notification: state.notifications[i],
                          ),
                          childCount: state.notifications.length,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_outlined,
            size: 64.r,
            color: AppColors.cyan,
          ),
          SizedBox(height: 16.h),
          Text('No Notifications', style: AppTextStyles.sectionTitle),
          SizedBox(height: 8.h),
          Text(
            'Push notifications and live\nannouncements will appear here.',
            style: AppTextStyles.bodyWhite,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
