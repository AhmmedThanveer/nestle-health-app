import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/models/survey_models.dart';
import '../../widgets/nestle_logo_widget.dart';
import '../../../core/utils/session_store.dart';
import '../../../view%20model/bloc/profile/profile_bloc.dart';
import '../../../view%20model/bloc/survey/survey_bloc.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/module_app_bar.dart';
import 'widgets/survey_radio_question_widget.dart';
import 'widgets/survey_text_question_widget.dart';

class SurveyScreen extends StatelessWidget {
  const SurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SurveyBloc(),
      child: const _SurveyView(),
    );
  }
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _SurveyView extends StatelessWidget {
  const _SurveyView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SurveyBloc, SurveyState>(
      listenWhen: (prev, curr) =>
          curr.status != prev.status &&
          (curr.status == SurveyStatus.submitted ||
              curr.status == SurveyStatus.error),
      listener: (context, state) {
        if (state.status == SurveyStatus.submitted) {
          AppSnackBar.showSuccess(
              context, 'Survey submitted successfully. Thank you!');
          Navigator.pop(context);
        } else if (state.status == SurveyStatus.error &&
            state.errorMessage != null) {
          AppSnackBar.showError(context, state.errorMessage!);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBlue,
        body: Stack(
          children: [
            // ── Background ──────────────────────────────────────────
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
                    stops: const [0.0, 0.3, 0.6, 1.0],
                    colors: [
                      AppColors.primaryBlue.withValues(alpha: 1.0),
                      AppColors.primaryBlue.withValues(alpha: 0.95),
                      AppColors.primaryBlue.withValues(alpha: 0.80),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // ── Content ─────────────────────────────────────────────
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ModuleAppBar(title: 'Survey'),
                  Expanded(
                    child: BlocBuilder<SurveyBloc, SurveyState>(
                      builder: (context, state) =>
                          _SurveyContent(state: state),
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

// ─── Content ──────────────────────────────────────────────────────────────────

class _SurveyContent extends StatelessWidget {
  final SurveyState state;

  const _SurveyContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final profileState = context.read<ProfileBloc>().state;
    final userId = profileState.user?.uid ??
        SessionStore.instance.currentUserId ??
        FirebaseAuth.instance.currentUser?.uid ??
        '';
    final eventId = profileState.user?.eventId ??
        SessionStore.instance.pendingEventId ??
        '';

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
            children: [
              const NestleLogoWidget(topPadding: 0),
              SizedBox(height: 20.h),

              // ── Questions ─────────────────────────────────────────
              ...SurveyState.questions.map((q) {
                if (q.type == QuestionType.radio) {
                  return SurveyRadioQuestionWidget(
                    key: ValueKey(q.id),
                    question: q,
                    selectedValue: state.answers[q.id],
                  );
                }
                return SurveyTextQuestionWidget(
                  key: ValueKey(q.id),
                  question: q,
                  initialValue: state.answers[q.id],
                );
              }),

              SizedBox(height: 8.h),
            ],
          ),
        ),

        // ── Submit button ──────────────────────────────────────────
        Padding(
          padding: EdgeInsets.fromLTRB(
            16.w,
            0,
            16.w,
            MediaQuery.of(context).padding.bottom + 16.h,
          ),
          child: CommonButton(
            title: 'Submit Survey',
            isLoading: state.status == SurveyStatus.submitting,
            onTap: state.status == SurveyStatus.submitting
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    context.read<SurveyBloc>().add(
                          SubmitSurveyEvent(
                            userId: userId,
                            eventId: eventId,
                          ),
                        );
                  },
          ),
        ),
      ],
    );
  }
}
