import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/di/service_locator.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../view%20model/bloc/ask_question/ask_question_bloc.dart';
import '../../../view%20model/bloc/ask_question/ask_question_event.dart';
import '../../../view%20model/bloc/ask_question/ask_question_state.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/animated_entrance_item.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_dropdown_field.dart';
import '../../widgets/common_textfield.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';

class AskQuestionScreen extends StatelessWidget {
  const AskQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AskQuestionBloc>()..add(const LoadSpeakersForQuestionEvent()),
      child: const _AskQuestionView(),
    );
  }
}

class _FieldError extends StatelessWidget {
  final String message;
  const _FieldError(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h, left: 4.w),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
// ─── View ─────────────────────────────────────────────────────────────────────

/// StatefulWidget holds TextEditingControllers only — no setState calls.
class _AskQuestionView extends StatefulWidget {
  const _AskQuestionView();

  @override
  State<_AskQuestionView> createState() => _AskQuestionViewState();
}

class _AskQuestionViewState extends State<_AskQuestionView> {
  final _nameController = TextEditingController();
  final _questionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
      listener: (_, __) => Navigator.maybePop(context),
      child: BlocListener<AskQuestionBloc, AskQuestionState>(
        listenWhen: (prev, curr) =>
            prev.status != curr.status &&
            (curr.status == AskQuestionStatus.submitted ||
                curr.status == AskQuestionStatus.failure),
        listener: (context, state) {
          if (state.status == AskQuestionStatus.submitted) {
            _nameController.clear();
            _questionController.clear();
            context.read<AskQuestionBloc>().add(const ResetAskQuestionEvent());
            AppSnackBar.showSuccess(context, 'Your question has been submitted!');
          } else {
            AppSnackBar.showError(
              context,
              state.errorMessage ?? 'Failed to submit question.',
            );
          }
        },
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primaryBlue,
          bottomNavigationBar: const NestleBottomNavigationBar(),
          body: Stack(
            fit: StackFit.expand,
            children: [
              // ── Background ──────────────────────────────────────
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
                    stops: const [0.0, 0.35, 0.62, 1.0],
                    colors: [
                      AppColors.primaryBlue.withValues(alpha: 0.95),
                      AppColors.primaryBlue.withValues(alpha: 0.85),
                      AppColors.primaryBlue.withValues(alpha: 0.55),
                      AppColors.primaryBlue.withValues(alpha: 0.80),
                    ],
                  ),
                ),
              ),

              // ── Content ─────────────────────────────────────────
              SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ModuleAppBar(title: AppStrings.askQuestionTitle),
                    SizedBox(height: 4.h),
                    NestleLogoWidget(topPadding: 0),
                    SizedBox(height: 20.h),

                    // ── Scrollable form fields ─────────────────────
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w,
                            MediaQuery.of(context).viewInsets.bottom + 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ── Your Name ──────────────────────────
                            AnimatedEntranceItem(
                              direction: EntranceDirection.ttb,
                              index: 0,
                              child: BlocBuilder<AskQuestionBloc, AskQuestionState>(
                                buildWhen: (p, c) => p.nameError != c.nameError,
                                builder: (context, state) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(AppStrings.yourName, style: AppTextStyles.aqFieldLabel),
                                    SizedBox(height: 10.h),
                                    CommonTextField(controller: _nameController, hintText: AppStrings.yourName),
                                    if (state.nameError != null)
                                      _FieldError(state.nameError!),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // ── Speaker ────────────────────────────
                            AnimatedEntranceItem(
                              direction: EntranceDirection.ttb,
                              index: 1,
                              child: BlocBuilder<AskQuestionBloc, AskQuestionState>(
                                buildWhen: (p, c) =>
                                    p.selectedSpeaker != c.selectedSpeaker ||
                                    p.speakerNames != c.speakerNames ||
                                    p.speakerError != c.speakerError,
                                builder: (context, state) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(AppStrings.speakerLabel, style: AppTextStyles.aqFieldLabel),
                                    SizedBox(height: 10.h),
                                    CommonDropdownField(
                                      hintText: AppStrings.selectSpeaker,
                                      value: state.selectedSpeaker,
                                      items: state.speakerNames,
                                      onChanged: (value) => context
                                          .read<AskQuestionBloc>()
                                          .add(SelectSpeakerEvent(value)),
                                    ),
                                    if (state.speakerError != null)
                                      _FieldError(state.speakerError!),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // ── Ask Question ───────────────────────
                            AnimatedEntranceItem(
                              direction: EntranceDirection.ttb,
                              index: 2,
                              child: BlocBuilder<AskQuestionBloc, AskQuestionState>(
                                buildWhen: (p, c) => p.questionError != c.questionError,
                                builder: (context, state) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(AppStrings.askQuestionTitle, style: AppTextStyles.aqFieldLabel),
                                    SizedBox(height: 10.h),
                                    CommonTextField(
                                      controller: _questionController,
                                      hintText: AppStrings.writeYourQuestion,
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline,
                                    ),
                                    if (state.questionError != null)
                                      _FieldError(state.questionError!),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ── Submit button pinned above nav bar ─────────
                    BlocBuilder<AskQuestionBloc, AskQuestionState>(
                      buildWhen: (prev, curr) => prev.status != curr.status,
                      builder: (context, state) {
                        final isLoading =
                            state.status == AskQuestionStatus.submitting;
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            20.w,
                            12.h,
                            20.w,
                            12.h + MediaQuery.of(context).padding.bottom,
                          ),
                          child: CommonButton(
                            title: AppStrings.submit,
                            isLoading: isLoading,
                            onTap: () => context.read<AskQuestionBloc>().add(
                              SubmitQuestionEvent(
                                name: _nameController.text,
                                question: _questionController.text,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
