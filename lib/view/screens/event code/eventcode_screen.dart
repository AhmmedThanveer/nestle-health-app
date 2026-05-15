import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:health_congress/app/routes/app_page_transition.dart';
import 'package:health_congress/core/constants/app_colors.dart';
import 'package:health_congress/core/constants/app_images.dart';
import 'package:health_congress/core/extensions/widget_extension.dart';
import 'package:health_congress/core/theme/app_textstyles.dart';

import 'package:health_congress/view/screens/login/login_screen.dart';
import 'package:health_congress/view/screens/register/register_screen.dart';

import 'package:health_congress/view/widgets/animated_screen_wrapper.dart';
import 'package:health_congress/view/widgets/auth_background_widget.dart';
import 'package:health_congress/view/widgets/auth_overlay_widget.dart';
import 'package:health_congress/view/widgets/common_back_button.dart';
import 'package:health_congress/view/widgets/common_button.dart';
import 'package:health_congress/view/widgets/common_textfield.dart';
import 'package:health_congress/view/widgets/nestle_logo_widget.dart';

import '../../../../../view model/bloc/event code/event_code_bloc.dart';
import '../../../../../view model/bloc/event code/event_code_event.dart';
import '../../../../../view model/bloc/event code/event_code_state.dart';

class EventCodeScreen extends StatelessWidget {
  EventCodeScreen({super.key});

  final TextEditingController eventCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventCodeBloc(),

      child: BlocConsumer<EventCodeBloc, EventCodeState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.push(
              context,

              AppPageTransition.fadeSlideTransition(RegisterScreen()),
            );
          }
        },

        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,

            resizeToAvoidBottomInset: false,

            appBar: AppBar(
              backgroundColor: Colors.transparent,

              elevation: 0,

              scrolledUnderElevation: 0,

              leadingWidth: 80.w,

              leading: Padding(
                padding: EdgeInsets.only(left: 20.w, top: 8.h),

                child: CommonBackButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

            body:
                AuthBackgroundWidget(
                  overlayChild: const AuthOverlayWidget(),
                  child: Image.asset(
                    AppImages.loginBg,

                    fit: BoxFit.cover,

                    alignment: Alignment.bottomCenter,

                    filterQuality: FilterQuality.high,
                  ),
                ).copyWith(
                  child: AnimatedScreenWrapper(
                    child: SafeArea(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),

                        padding: EdgeInsets.symmetric(horizontal: 24.w),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            /// LOGO
                            const NestleLogoWidget(),

                            SizedBox(height: 70.h),

                            /// WHITE INFO CARD
                            Container(
                              width: double.infinity,

                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 24.h,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(24.r),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),

                                    blurRadius: 18,

                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),

                              child: Text(
                                'Enter your event code to\ncontinue with account\nregistration.',

                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  color: AppColors.lightBlue,

                                  fontSize: 20.sp,

                                  height: 1.5,

                                  fontWeight: FontWeight.w700,

                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),

                            SizedBox(height: 55.h),

                            /// LABEL
                            Text('Event Code', style: AppTextStyles.labelStyle),

                            SizedBox(height: 14.h),

                            /// TEXTFIELD
                            CommonTextField(
                              hintText: 'Enter a event code',

                              controller: eventCodeController,
                            ),

                            /// ERROR TEXT
                            if (state.errorMessage != null)
                              Padding(
                                padding: EdgeInsets.only(top: 14.h, left: 4.w),

                                child: Text(
                                  state.errorMessage!,

                                  style: TextStyle(
                                    color: Colors.redAccent,

                                    fontSize: 14.sp,

                                    fontWeight: FontWeight.w500,

                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),

                            SizedBox(height: 50.h),

                            /// CONTINUE BUTTON
                            /// CONTINUE BUTTON
                            CommonButton(
                              title: 'Submit',

                              onTap: () {
                                FocusScope.of(context).unfocus();

                                context.read<EventCodeBloc>().add(
                                  ValidateEventCodeEvent(
                                    code: eventCodeController.text.trim(),
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: 34.h),

                            /// LOGIN TEXT
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },

                                child: Text(
                                  'Or Login to an Account',

                                  style: TextStyle(
                                    color: Colors.white,

                                    fontSize: 18.sp,

                                    fontWeight: FontWeight.w400,

                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 250.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
