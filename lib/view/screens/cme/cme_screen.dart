import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../view%20model/bloc/auth/auth_bloc.dart';
import '../../../view%20model/bloc/auth/auth_state.dart';
import '../../../view%20model/bloc/cme/cme_bloc.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';

class CmeScreen extends StatelessWidget {
  const CmeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final authState = context.read<AuthBloc>().state;
        final bloc = CmeBloc();
        if (authState is AuthAuthenticatedState) {
          bloc.add(CheckCmeEligibilityEvent(authState.user.uid));
        }
        return bloc;
      },
      child: const _CmeView(),
    );
  }
}

class _CmeView extends StatelessWidget {
  const _CmeView();

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ModuleAppBar(title: 'CME Certificate'),
                const NestleLogoWidget(),
                Expanded(
                  child: BlocBuilder<CmeBloc, CmeState>(
                    builder: (context, state) {
                      return switch (state.status) {
                        CmeStatus.initial ||
                        CmeStatus.loading =>
                          const Center(
                            child: CircularProgressIndicator(
                                color: Colors.white),
                          ),
                        CmeStatus.eligible => _EligibleBody(
                            certificateUrl: state.certificateUrl),
                        CmeStatus.notEligible => _NotEligibleBody(
                            onRetry: () {
                              final authState =
                                  context.read<AuthBloc>().state;
                              if (authState is AuthAuthenticatedState) {
                                context.read<CmeBloc>().add(
                                    CheckCmeEligibilityEvent(
                                        authState.user.uid));
                              }
                            },
                          ),
                        CmeStatus.error => _NotEligibleBody(
                            onRetry: () {
                              final authState =
                                  context.read<AuthBloc>().state;
                              if (authState is AuthAuthenticatedState) {
                                context.read<CmeBloc>().add(
                                    CheckCmeEligibilityEvent(
                                        authState.user.uid));
                              }
                            },
                          ),
                      };
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Not Eligible ──────────────────────────────────────────────────────────────

class _NotEligibleBody extends StatelessWidget {
  final VoidCallback onRetry;
  const _NotEligibleBody({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_busy_rounded,
              size: 72.r,
              color: Colors.white.withValues(alpha: 0.85),
            ),
            SizedBox(height: 24.h),
            Text(
              'You have not attended the event.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.4,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'No CME available.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15.sp,
                color: Colors.white.withValues(alpha: 0.75),
              ),
            ),
            SizedBox(height: 32.h),
            OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 1.5),
                padding: EdgeInsets.symmetric(
                    horizontal: 48.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Eligible ──────────────────────────────────────────────────────────────────

class _EligibleBody extends StatelessWidget {
  final String? certificateUrl;
  const _EligibleBody({this.certificateUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.workspace_premium_rounded,
              size: 72.r,
              color: const Color(0xFFFFD700),
            ),
            SizedBox(height: 24.h),
            Text(
              'Congratulations!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your CME certificate is ready.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15.sp,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            if (certificateUrl != null) ...[
              SizedBox(height: 32.h),
              ElevatedButton.icon(
                onPressed: () {
                  // Open certificateUrl in browser or PDF viewer
                },
                icon: Icon(Icons.download_rounded, size: 20.r),
                label: Text(
                  'Download Certificate',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryBlue,
                  padding: EdgeInsets.symmetric(
                      horizontal: 32.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
