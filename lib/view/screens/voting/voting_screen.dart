import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../view%20model/bloc/voting/voting_bloc.dart';
import '../../widgets/animated_entrance_item.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import '../../widgets/screen_state_widget.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VotingBloc()..add(const LoadActivePollEvent()),
      child: const _VotingView(),
    );
  }
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _VotingView extends StatelessWidget {
  const _VotingView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<VotingBloc, VotingState>(
      listenWhen: (prev, curr) =>
          curr.status == VotingStatus.voted &&
          prev.status != VotingStatus.voted,
      listener: (context, _) {
        AppSnackBar.showSuccess(context, 'Your vote has been submitted!');
        context.read<VotingBloc>().add(const LoadActivePollEvent());
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBlue,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppImages.loginBg,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              filterQuality: FilterQuality.low,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.35, 0.65, 1.0],
                  colors: [
                    AppColors.primaryBlue.withValues(alpha: 0.97),
                    AppColors.primaryBlue.withValues(alpha: 0.88),
                    AppColors.primaryBlue.withValues(alpha: 0.60),
                    AppColors.primaryBlue.withValues(alpha: 0.80),
                  ],
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ModuleAppBar(title: 'Live Voting'),
                  SizedBox(height: 4.h),
                  const NestleLogoWidget(topPadding: 0),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: BlocBuilder<VotingBloc, VotingState>(
                      builder: (context, state) {
                        return switch (state.status) {
                          VotingStatus.initial ||
                          VotingStatus.loading =>
                            const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          VotingStatus.noInternet =>
                            ScreenStateWidget.noInternet(
                              onRetry: () => context
                                  .read<VotingBloc>()
                                  .add(const LoadActivePollEvent()),
                            ),
                          VotingStatus.serverError =>
                            ScreenStateWidget.serverError(
                              message: state.errorMessage,
                              onRetry: () => context
                                  .read<VotingBloc>()
                                  .add(const LoadActivePollEvent()),
                            ),
                          VotingStatus.empty => ScreenStateWidget.empty(
                              title: 'No active question at the moment.',
                              subtitle: 'Please wait for the next question.',
                              actionLabel: 'Refresh',
                              onAction: () => context
                                  .read<VotingBloc>()
                                  .add(const LoadActivePollEvent()),
                            ),
                          VotingStatus.active ||
                          VotingStatus.submitting ||
                          VotingStatus.voted =>
                            _PollBody(state: state),
                        };
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Poll body ────────────────────────────────────────────────────────────────

class _PollBody extends StatelessWidget {
  final VotingState state;

  const _PollBody({required this.state});

  @override
  Widget build(BuildContext context) {
    final poll = state.poll;
    if (poll == null) return const SizedBox.shrink();

    final isSubmitting = state.status == VotingStatus.submitting;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Question card
                AnimatedEntranceItem(
                  direction: EntranceDirection.ttb,
                  index: 0,
                  child: Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.20),
                          width: 1),
                    ),
                    child: Text(
                      poll.question,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.45,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Options
                ...poll.options.asMap().entries.map((entry) {
                  final i = entry.key;
                  final option = entry.value;
                  final isSelected = state.selectedOption == option.text;

                  return AnimatedEntranceItem(
                    direction: EntranceDirection.rtl,
                    index: i + 1,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: GestureDetector(
                        onTap: isSubmitting
                            ? null
                            : () => context
                                .read<VotingBloc>()
                                .add(SelectOptionEvent(option.text)),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.25),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 22.r,
                                height: 22.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? AppColors.primaryBlue
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primaryBlue
                                        : Colors.white54,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Icon(Icons.check_rounded,
                                        color: Colors.white, size: 14.r)
                                    : null,
                              ),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: Text(
                                  option.text,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 15.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? AppColors.primaryBlue
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        // Submit button
        Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            0,
            20.w,
            24.h + MediaQuery.of(context).padding.bottom,
          ),
          child: GestureDetector(
            onTap: (state.selectedOption == null || isSubmitting)
                ? null
                : () => context.read<VotingBloc>().add(
                      SubmitVoteEvent(
                        pollId: poll.id,
                        selectedOption: state.selectedOption!,
                      ),
                    ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: state.selectedOption != null && !isSubmitting
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: isSubmitting
                    ? SizedBox(
                        width: 22.r,
                        height: 22.r,
                        child: CircularProgressIndicator(
                          color: AppColors.primaryBlue,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(
                        'Submit Vote',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: state.selectedOption != null
                              ? AppColors.primaryBlue
                              : Colors.white60,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
