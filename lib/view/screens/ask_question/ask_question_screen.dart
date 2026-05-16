import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/speaker_models.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../view%20model/bloc/ask_question/ask_question_bloc.dart';
import '../../../view%20model/bloc/ask_question/ask_question_event.dart';
import '../../../view%20model/bloc/ask_question/ask_question_state.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/animated_entrance_item.dart';
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
      create: (_) => AskQuestionBloc(),
      child: const _AskQuestionView(),
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

  static final _speakerNames = SpeakersData.all.map((s) => s.name).toList();

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
            curr.status == AskQuestionStatus.submitted &&
            prev.status != AskQuestionStatus.submitted,
        listener: (context, _) {
          _nameController.clear();
          _questionController.clear();
          context.read<AskQuestionBloc>().add(const ResetAskQuestionEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Your question has been submitted!'),
              backgroundColor: AppColors.primaryBlue,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          );
        },
        child: Scaffold(
          extendBody: true,
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
                        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ── Your Name ──────────────────────────
                            AnimatedEntranceItem(
                              direction: EntranceDirection.ttb,
                              index: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(AppStrings.yourName, style: AppTextStyles.aqFieldLabel),
                                  SizedBox(height: 10.h),
                                  CommonTextField(controller: _nameController, hintText: AppStrings.yourName),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // ── Speaker ────────────────────────────
                            AnimatedEntranceItem(
                              direction: EntranceDirection.ttb,
                              index: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(AppStrings.speakerLabel, style: AppTextStyles.aqFieldLabel),
                                  SizedBox(height: 10.h),
                                  BlocBuilder<AskQuestionBloc, AskQuestionState>(
                                    buildWhen: (prev, curr) =>
                                        prev.selectedSpeaker != curr.selectedSpeaker,
                                    builder: (context, state) => CommonDropdownField(
                                      hintText: AppStrings.selectSpeaker,
                                      value: state.selectedSpeaker,
                                      items: _speakerNames,
                                      onChanged: (value) => context
                                          .read<AskQuestionBloc>()
                                          .add(SelectSpeakerEvent(value)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // ── Ask Question ───────────────────────
                            AnimatedEntranceItem(
                              direction: EntranceDirection.ttb,
                              index: 2,
                              child: Column(
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
                                ],
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
