import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/speaker_models.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';

class SpeakerDetailScreen extends StatelessWidget {
  final Speaker speaker;

  const SpeakerDetailScreen({super.key, required this.speaker});

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
          // StackFit.expand forces the Stack to fill the Scaffold body,
          // preventing the SingleChildScrollView from inflating the Stack
          // beyond screen height (which would push the skyline off-screen).
          fit: StackFit.expand,
          children: [
            // ── Background image ──────────────────────────────────
            Image.asset(
              AppImages.loginBg,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              filterQuality: FilterQuality.low,
            ),

            // ── Gradient overlay ──────────────────────────────────
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.35, 0.65, 1.0],
                  colors: [
                    AppColors.primaryBlue.withValues(alpha: 1.0),
                    AppColors.primaryBlue.withValues(alpha: 0.95),
                    AppColors.primaryBlue.withValues(alpha: 0.75),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // ── Scrollable content ────────────────────────────────
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: 80.h + MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ModuleAppBar(title: AppStrings.speakerDetail),
                    SizedBox(height: 4.h),

                    NestleLogoWidget(topPadding: 0),
                    SizedBox(height: 28.h),

                    // ── Circular avatar ───────────────────────────
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.lightBlue,
                            width: 3.r,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 58.r,
                          backgroundColor: AppColors.glassBg,
                          backgroundImage: NetworkImage(speaker.imageUrl),
                          onBackgroundImageError: (_, __) {},
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // ── Detail card ───────────────────────────────
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.speakerDetailCardBg,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.speakerName,
                            style: AppTextStyles.speakerDetailLabel,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            speaker.name,
                            style: AppTextStyles.speakerDetailValue,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            AppStrings.speakerBio,
                            style: AppTextStyles.speakerDetailLabel,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            speaker.bio,
                            style: AppTextStyles.speakerDetailValue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
