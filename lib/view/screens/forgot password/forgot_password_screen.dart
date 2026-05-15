import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/core/extensions/widget_extension.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_textstyles.dart';

import '../../../../../view/widgets/animated_screen_wrapper.dart';
import '../../../../../view/widgets/auth_background_widget.dart';
import '../../../../../view/widgets/auth_overlay_widget.dart';
import '../../../../../view/widgets/common_back_button.dart';
import '../../../../../view/widgets/common_button.dart';
import '../../../../../view/widgets/common_text_button.dart';
import '../../../../../view/widgets/common_textfield.dart';
import '../../../../../view/widgets/nestle_logo_widget.dart';

import '../../../../../view model/bloc/login_bloc.dart';
import '../../../../../view model/bloc/login_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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

                /// CONTENT
              ).copyWith(
                child: AnimatedScreenWrapper(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),

                      padding: EdgeInsets.symmetric(horizontal: 24.w),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SizedBox(height: 20.h),

                          /// LOGO
                          const NestleLogoWidget(),

                          SizedBox(height: 60.h),

                          /// EMAIL
                          Text(
                            AppStrings.email,

                            style: AppTextStyles.labelStyle,
                          ),

                          SizedBox(height: 14.h),

                          /// FIELD
                          CommonTextField(
                            hintText: AppStrings.enterEmail,

                            controller: emailController,

                            keyboardType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: 50.h),

                          /// BUTTON
                          CommonButton(
                            title: 'Submit',

                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                          ),

                          SizedBox(height: 35.h),

                          /// LOGIN
                          Center(
                            child: CommonTextButton(
                              title: 'Or Login to an Account',

                              onTap: () {
                                Navigator.pop(context);
                              },
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
    );
  }
}
