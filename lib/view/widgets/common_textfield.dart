import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/view%20model/bloc/textfield%20bloc/common_textfield_event.dart';
import 'package:health_congress/view%20model/bloc/textfield%20bloc/common_textfield_state.dart';
import 'package:health_congress/view%20model/bloc/textfield%20bloc/commontextfield_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../core/theme/app_textstyles.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;

  const CommonTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommonTextFieldBloc(validator: validator),
      child: BlocBuilder<CommonTextFieldBloc, CommonTextFieldState>(
        builder: (context, state) {
          final bool hasError = state.isTouched && state.errorText != null;

          final Color borderColor;
          if (hasError) {
            borderColor = Colors.redAccent;
          } else if (state.isFocused) {
            borderColor = AppColors.lightBlue;
          } else {
            borderColor = AppColors.borderColor;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: maxLines == 1 ? 68.h : null,
                alignment:
                    maxLines == 1 ? Alignment.center : Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                child: Focus(
                  onFocusChange: (hasFocus) {
                    context
                        .read<CommonTextFieldBloc>()
                        .add(TextFieldFocusChanged(hasFocus));
                    // Re-validate with current text when field loses focus
                    if (!hasFocus) {
                      context
                          .read<CommonTextFieldBloc>()
                          .add(TextFieldValueChanged(controller.text));
                    }
                  },
                  child: TextFormField(
                    controller: controller,
                    obscureText: isPassword,
                    keyboardType: keyboardType,
                    maxLines: isPassword ? 1 : maxLines,
                    onChanged: (value) {
                      context
                          .read<CommonTextFieldBloc>()
                          .add(TextFieldValueChanged(value));
                    },
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.sp,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                    ),
                    cursorColor: AppColors.white,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: AppTextStyles.hintStyle,
                      isCollapsed: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 18.h,
                      ),
                      suffixIcon: suffixIcon,
                    ),
                  ),
                ),
              ),
              if (hasError)
                Padding(
                  padding: EdgeInsets.only(top: 6.h, left: 4.w),
                  child: Text(
                    state.errorText!,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

