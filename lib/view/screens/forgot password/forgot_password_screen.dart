import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/core/extensions/widget_extension.dart';
import 'package:health_congress/core/constants/app_images.dart';
import 'package:health_congress/core/constants/app_strings.dart';
import 'package:health_congress/core/theme/app_textstyles.dart';
import 'package:health_congress/view/widgets/animated_screen_wrapper.dart';
import 'package:health_congress/view/widgets/auth_background_widget.dart';
import 'package:health_congress/view/widgets/auth_overlay_widget.dart';
import 'package:health_congress/view/widgets/common_back_button.dart';
import 'package:health_congress/view/widgets/common_button.dart';
import 'package:health_congress/view/widgets/common_text_button.dart';
import 'package:health_congress/view/widgets/common_textfield.dart';
import 'package:health_congress/view/widgets/nestle_logo_widget.dart';
import 'package:health_congress/view/widgets/app_snackbar.dart';
import 'package:health_congress/view%20model/bloc/login_bloc.dart';
import 'package:health_congress/view%20model/bloc/login_state.dart';
import 'package:health_congress/view%20model/bloc/login_event.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (prev, curr) =>
          prev.isPasswordResetSent != curr.isPasswordResetSent ||
          prev.passwordResetError != curr.passwordResetError,
      listener: (context, state) {
        if (state.isPasswordResetSent) {
          AppSnackBar.showSuccess(context, AppStrings.passwordResetSent);
          Navigator.pop(context);
        } else if (state.passwordResetError != null) {
          AppSnackBar.showError(context, state.passwordResetError!);
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
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),
          body: AuthBackgroundWidget(
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
                      SizedBox(height: 20.h),
                      const SizedBox(
                        width: double.infinity,
                        child: NestleLogoWidget(),
                      ),
                      SizedBox(height: 60.h),

                      Text(AppStrings.email, style: AppTextStyles.labelStyle),
                      SizedBox(height: 14.h),

                      CommonTextField(
                        hintText: AppStrings.enterEmail,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 50.h),

                      CommonButton(
                        title: 'Submit',
                        isLoading: state.isPasswordResetLoading,
                        onTap: state.isPasswordResetLoading
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                context.read<LoginBloc>().add(
                                      SendPasswordResetEvent(
                                        email: emailController.text,
                                      ),
                                    );
                              },
                      ),
                      SizedBox(height: 35.h),

                      Center(
                        child: CommonTextButton(
                          title: AppStrings.loginToAccount,
                          onTap: () => Navigator.pop(context),
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
