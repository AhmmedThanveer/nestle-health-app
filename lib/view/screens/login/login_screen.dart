import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/app/routes/app_page_transition.dart';
import 'package:health_congress/view/screens/event_code/eventcode_screen.dart';
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
import '../../../../../view model/bloc/navigation/navigation_bloc.dart';
import '../../../../view/widgets/app_snackbar.dart';
import '../../../../view/widgets/disclaimer_bottom_sheet.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static String? _emailValidator(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Email is required' : null;

  static String? _passwordValidator(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Password is required' : null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (prev, cur) =>
          (cur.isLoginSuccess && !prev.isLoginSuccess) ||
          (cur.errorMessage != null && cur.errorMessage != prev.errorMessage),
      listener: (context, state) {
        if (state.isLoginSuccess) {
          AppSnackBar.showSuccess(context, 'Login Successfully');
          DisclaimerBottomSheet.show(
            context,
            onAccepted: () {
              context.read<NavigationBloc>().add(const NavigateToTabEvent(0));
              AppRoutes.pushAndRemoveUntil(context, AppRoutes.main);
            },
          );
        } else if (state.errorMessage != null) {
          AppSnackBar.showError(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primaryBlue,
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
                    stops: const [0.0, 0.35, 0.65, 1.0],
                    colors: [
                      AppColors.primaryBlue.withValues(alpha: 1.0),
                      AppColors.primaryBlue.withValues(alpha: 0.92),
                      AppColors.primaryBlue.withValues(alpha: 0.60),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // ── Content ─────────────────────────────────────────
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: NestleLogoWidget(),
                      ),
                      SizedBox(height: 90.h),

                      // Email
                      Text(AppStrings.email, style: AppTextStyles.labelStyle),
                      SizedBox(height: 10.h),
                      CommonTextField(
                        hintText: AppStrings.enterEmail,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _emailValidator,
                      ),
                      SizedBox(height: 24.h),

                      // Password
                      Text(
                        AppStrings.password,
                        style: AppTextStyles.labelStyle,
                      ),
                      SizedBox(height: 10.h),
                      CommonTextField(
                        hintText: AppStrings.enterPassword,
                        controller: passwordController,
                        isPassword: state.obscurePassword,
                        validator: _passwordValidator,
                        suffixIcon: IconButton(
                          onPressed: () => context.read<LoginBloc>().add(
                            TogglePasswordVisibilityEvent(),
                          ),
                          icon: Icon(
                            state.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.white,
                            size: 22.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 36.h),

                      // Login button
                      CommonButton(
                        title: AppStrings.login,
                        isLoading: state.isLoading,
                        onTap: state.isLoading
                            ? null
                            : () => context.read<LoginBloc>().add(
                                LoginButtonPressedEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              ),
                      ),
                      SizedBox(height: 28.h),

                      // Forgot password
                      Center(
                        child: CommonTextButton(
                          title: AppStrings.forgotPassword,
                          onTap: () => Navigator.push(
                            context,
                            AppPageTransition.fadeSlideTransition(
                              ForgotPasswordScreen(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Create account
                      Center(
                        child: CommonTextButton(
                          title: AppStrings.createAccount,
                          onTap: () => Navigator.push(
                            context,
                            AppPageTransition.fadeSlideTransition(
                              EventCodeScreen(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 60.h),
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
