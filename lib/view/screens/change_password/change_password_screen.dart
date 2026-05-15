import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../view%20model/bloc/change_password/change_password_bloc.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/module_app_bar.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordBloc(),
      child: const _ChangePasswordView(),
    );
  }
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _ChangePasswordView extends StatelessWidget {
  const _ChangePasswordView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == ChangePasswordStatus.success) {
          AppSnackBar.showSuccess(context, 'Password changed successfully.');
          Navigator.pop(context);
        } else if (state.status == ChangePasswordStatus.error &&
            state.errorMessage != null) {
          AppSnackBar.showError(context, state.errorMessage!);
          context
              .read<ChangePasswordBloc>()
              .add(const ChangePasswordResetEvent());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBlue,
        body: Stack(
          children: [
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
                    stops: const [0.0, 0.35, 0.65, 1.0],
                    colors: [
                      AppColors.primaryBlue.withValues(alpha: 0.98),
                      AppColors.primaryBlue.withValues(alpha: 0.90),
                      AppColors.primaryBlue.withValues(alpha: 0.75),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ModuleAppBar(title: AppStrings.changePassword),
                  Expanded(
                    child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                      builder: (context, state) =>
                          _ChangePasswordBody(state: state),
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

// ─── Body ─────────────────────────────────────────────────────────────────────

class _ChangePasswordBody extends StatefulWidget {
  final ChangePasswordState state;
  const _ChangePasswordBody({required this.state});

  @override
  State<_ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<_ChangePasswordBody> {
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    final current = _currentCtrl.text.trim();
    final newPass = _newCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      AppSnackBar.showError(context, 'Please fill in all fields.');
      return;
    }
    if (newPass.length < 6) {
      AppSnackBar.showError(
          context, 'New password must be at least 6 characters.');
      return;
    }
    if (newPass != confirm) {
      AppSnackBar.showError(context, 'Passwords do not match.');
      return;
    }

    context.read<ChangePasswordBloc>().add(
          ChangePasswordSubmitEvent(
            currentPassword: current,
            newPassword: newPass,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        widget.state.status == ChangePasswordStatus.loading;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Text(
                      AppStrings.appTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      AppStrings.subtitle,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),

              // Current Password
              _FieldLabel('Current Password'),
              SizedBox(height: 8.h),
              _PasswordField(
                controller: _currentCtrl,
                hint: 'Enter current password',
                obscure: _obscureCurrent,
                onToggle: () =>
                    setState(() => _obscureCurrent = !_obscureCurrent),
              ),
              SizedBox(height: 20.h),

              // New Password
              _FieldLabel('New Password'),
              SizedBox(height: 8.h),
              _PasswordField(
                controller: _newCtrl,
                hint: 'Enter new password',
                obscure: _obscureNew,
                onToggle: () =>
                    setState(() => _obscureNew = !_obscureNew),
              ),
              SizedBox(height: 20.h),

              // Re-Enter New Password
              _FieldLabel('Re-Enter New Password'),
              SizedBox(height: 8.h),
              _PasswordField(
                controller: _confirmCtrl,
                hint: 'Enter new password',
                obscure: _obscureConfirm,
                onToggle: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
            ],
          ),
        ),

        // Save button
        Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            0,
            20.w,
            MediaQuery.of(context).padding.bottom + 16.h,
          ),
          child: CommonButton(
            title: 'Save',
            isLoading: isLoading,
            onTap: isLoading ? null : _submit,
          ),
        ),
      ],
    );
  }
}

// ─── Label ────────────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
      ),
    );
  }
}

// ─── Password field ───────────────────────────────────────────────────────────

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        cursorColor: Colors.white,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.hintColor,
            fontSize: 16.sp,
            fontFamily: 'Roboto',
          ),
          isCollapsed: true,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
          suffixIcon: IconButton(
            icon: Icon(
              obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.white54,
              size: 22.r,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }
}
