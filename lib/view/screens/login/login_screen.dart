import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/app/routes/app_page_transition.dart';
import 'package:health_congress/view/screens/event%20code/eventcode_screen.dart';
import 'package:health_congress/view/screens/forgot%20password/forgot_password_screen.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_textstyles.dart';

import '../../../../../view/widgets/common_button.dart';
import '../../../../../view/widgets/common_text_button.dart';
import '../../../../../view/widgets/common_textfield.dart';
import '../../../../../view/widgets/nestle_logo_widget.dart';

import '../../../../../app/routes/app_routes.dart';
import '../../../../../view model/bloc/login_bloc.dart';
import '../../../../../view model/bloc/login_event.dart';
import '../../../../../view model/bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (prev, cur) => cur.isLoginSuccess && !prev.isLoginSuccess,
      listener: (context, state) {
        AppRoutes.pushAndRemoveUntil(context, AppRoutes.main);
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,

          body: Stack(
            children: [
              /// BACKGROUND IMAGE
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth,

                      height: constraints.maxHeight,

                      child: Image.asset(
                        AppImages.loginBg,

                        fit: BoxFit.cover,

                        alignment: Alignment.bottomCenter,

                        filterQuality: FilterQuality.high,
                      ),
                    );
                  },
                ),
              ),

              /// BLUE OVERLAY
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,

                      end: Alignment.bottomCenter,

                      colors: [
                        AppColors.primaryBlue.withOpacity(0.92),

                        AppColors.primaryBlue.withOpacity(0.76),

                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              /// CONTENT
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// LOGO
                      const NestleLogoWidget(),

                      SizedBox(height: 130.h),

                      /// EMAIL LABEL
                      Text(AppStrings.email, style: AppTextStyles.labelStyle),

                      SizedBox(height: 14.h),

                      /// EMAIL FIELD
                      CommonTextField(
                        hintText: AppStrings.enterEmail,

                        controller: emailController,

                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: 28.h),

                      /// PASSWORD LABEL
                      Text(
                        AppStrings.password,

                        style: AppTextStyles.labelStyle,
                      ),

                      SizedBox(height: 14.h),

                      /// PASSWORD FIELD
                      CommonTextField(
                        hintText: AppStrings.enterPassword,

                        controller: passwordController,

                        isPassword: state.obscurePassword,

                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                              TogglePasswordVisibilityEvent(),
                            );
                          },

                          icon: Icon(
                            state.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,

                            color: AppColors.white,

                            size: 22.sp,
                          ),
                        ),
                      ),

                      SizedBox(height: 45.h),

                      /// LOGIN BUTTON
                      CommonButton(
                        title: AppStrings.login,

                        onTap: () {
                          context.read<LoginBloc>().add(
                            LoginButtonPressedEvent(
                              email: emailController.text.trim(),

                              password: passwordController.text.trim(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 30.h),

                      /// CREATE ACCOUNT
                      SizedBox(height: 32.h),

                      /// FORGOT PASSWORD
                      Center(
                        child: CommonTextButton(
                          title: AppStrings.forgotPassword,

                          onTap: () {
                            Navigator.push(
                              context,

                              AppPageTransition.fadeSlideTransition(
                                ForgotPasswordScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 30.h),

                      /// CREATE ACCOUNT
                      Center(
                        child: CommonTextButton(
                          title: AppStrings.createAccount,

                          onTap: () {
                            Navigator.push(
                              context,

                              AppPageTransition.fadeSlideTransition(
                                EventCodeScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
