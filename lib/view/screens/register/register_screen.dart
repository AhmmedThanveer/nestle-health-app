import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../core/utils/validators.dart';
import '../../../view%20model/bloc/register/register_bloc.dart';
import '../../widgets/animated_screen_wrapper.dart';
import '../../widgets/city_bottomsheet.dart';
import '../../widgets/common_back_button.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_dropdown_field.dart';
import '../../widgets/common_text_button.dart';
import '../../widgets/common_textfield.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/disclaimer_bottom_sheet.dart';
import '../../widgets/nestle_logo_widget.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: const _RegisterView(),
    );
  }
}

// â”€â”€â”€ View (holds all local state & controllers) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  // â”€â”€ Controllers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  final _firstNameCtrl = TextEditingController();
  final _familyNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _saudiCouncilCtrl = TextEditingController();
  final _workPlaceCtrl = TextEditingController();

  // â”€â”€ Local state â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  String? _selectedProfession;
  String? _selectedTopic;
  String? _selectedCity;
  bool _obscurePassword = true;

  /// Set to true after first register-button press to show dropdown/city errors
  bool _submitted = false;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _familyNameCtrl.dispose();
    _emailCtrl.dispose();
    _mobileCtrl.dispose();
    _passwordCtrl.dispose();
    _saudiCouncilCtrl.dispose();
    _workPlaceCtrl.dispose();
    super.dispose();
  }

  // â”€â”€ Validation â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  /// Returns the first validation error found, or null if all fields are valid.
  String? _validateAll() {
    if (_firstNameCtrl.text.trim().isEmpty) return AppStrings.firstNameRequired;
    if (_familyNameCtrl.text.trim().isEmpty)
      return AppStrings.familyNameRequired;

    final emailErr = ValidationUtils.validateEmail(_emailCtrl.text);
    if (emailErr != null) return emailErr;

    final mobileErr = ValidationUtils.validateMobile(_mobileCtrl.text);
    if (mobileErr != null) return mobileErr;

    final passErr = ValidationUtils.validatePassword(_passwordCtrl.text);
    if (passErr != null) return passErr;

    if (_selectedProfession == null) return AppStrings.professionRequired;
    if (_selectedTopic == null) return AppStrings.secondaryTopicsRequired;
    if (_selectedCity == null) return AppStrings.cityRequired;

    if (_saudiCouncilCtrl.text.trim().isEmpty) {
      return AppStrings.saudiCouncilRequired;
    }
    if (_workPlaceCtrl.text.trim().isEmpty)
      return AppStrings.placeOfWorkRequired;

    return null;
  }

  // â”€â”€ Submit handler â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  void _onRegisterPressed(BuildContext context) {
    FocusScope.of(context).unfocus();

    setState(() => _submitted = true);

    final error = _validateAll();
    if (error != null) {
      AppSnackBar.showError(context, error);
      return;
    }

    context.read<RegisterBloc>().add(
      RegisterButtonPressedEvent(
        firstName: _firstNameCtrl.text.trim(),
        familyName: _familyNameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        mobile: _mobileCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
        profession: _selectedProfession!,
        topic: _selectedTopic!,
        city: _selectedCity!,
        saudiCouncil: _saudiCouncilCtrl.text.trim(),
        placeOfWork: _workPlaceCtrl.text.trim(),
      ),
    );
  }

  // â”€â”€ Build â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listenWhen: (prev, cur) =>
          cur.isSuccess && !prev.isSuccess ||
          cur.errorMessage != null && cur.errorMessage != prev.errorMessage,
      listener: (context, state) {
        if (state.isSuccess) {
          AppSnackBar.showSuccess(context, AppStrings.registrationSuccess);
          DisclaimerBottomSheet.show(
            context,
            onAccepted: () =>
                AppRoutes.pushAndRemoveUntil(context, AppRoutes.main),
          );
          return;
        }
        if (state.errorMessage != null) {
          AppSnackBar.showError(context, state.errorMessage!);
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
              child: CommonBackButton(onTap: () => Navigator.pop(context)),
            ),
          ),

          body: Stack(
            children: [
              // â”€â”€ Background â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Image.asset(
                      AppImages.loginBg,
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),

              // â”€â”€ Gradient overlay â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primaryBlue.withValues(alpha: 0.94),
                        AppColors.primaryBlue.withValues(alpha: 0.78),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // â”€â”€ Form content â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
              AnimatedScreenWrapper(
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        const NestleLogoWidget(),

                        SizedBox(height: 48.h),

                        // â”€â”€ First Name â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _label(AppStrings.firstName),
                        CommonTextField(
                          hintText: AppStrings.enterFirstName,
                          controller: _firstNameCtrl,
                          validator: (v) => ValidationUtils.validateRequired(
                            value: v ?? '',
                            fieldName: 'First name',
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // â”€â”€ Family Name â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _label(AppStrings.familyName),
                        CommonTextField(
                          hintText: AppStrings.enterFamilyName,
                          controller: _familyNameCtrl,
                          validator: (v) => ValidationUtils.validateRequired(
                            value: v ?? '',
                            fieldName: 'Family name',
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // â”€â”€ Email â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _label(AppStrings.email),
                        CommonTextField(
                          hintText: AppStrings.enterEmail,
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) =>
                              ValidationUtils.validateEmail(v ?? ''),
                        ),

                        SizedBox(height: 24.h),

                        // â”€â”€ Mobile â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _label(AppStrings.mobileNumber),
                        CommonTextField(
                          hintText: AppStrings.enterMobileNumber,
                          controller: _mobileCtrl,
                          keyboardType: TextInputType.phone,
                          validator: (v) =>
                              ValidationUtils.validateMobile(v ?? ''),
                        ),

                        SizedBox(height: 24.h),

                        // â”€â”€ Password â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _label(AppStrings.password),
                        CommonTextField(
                          hintText: AppStrings.enterPassword,
                          controller: _passwordCtrl,
                          isPassword: _obscurePassword,
                          validator: (v) =>
                              ValidationUtils.validatePassword(v ?? ''),
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white,
                              size: 22.r,
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // â”€â”€ Profession dropdown â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _label(AppStrings.profession),
                        CommonDropdownField(
                          hintText: AppStrings.enterProfession,
                          value: _selectedProfession,
                          items: AppStrings.professionList,
                          onChanged: (v) =>
                              setState(() => _selectedProfession = v),
                        ),
                        _dropdownError(
                          _submitted && _selectedProfession == null,
                          AppStrings.professionRequired,
                        ),

                        SizedBox(height: 24.h),

                        // â”€â”€ Secondary topics dropdown â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _label(AppStrings.secondaryTopics),
                        CommonDropdownField(
                          hintText: AppStrings.enterSecondaryTopics,
                          value: _selectedTopic,
                          items: AppStrings.secondaryTopicsList,
                          onChanged: (v) => setState(() => _selectedTopic = v),
                        ),
                        _dropdownError(
                          _submitted && _selectedTopic == null,
                          AppStrings.secondaryTopicsRequired,
                        ),

                        SizedBox(height: 24.h),

                        // â”€â”€ City â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _label(AppStrings.city),
                        _CitySelector(
                          selectedCity: _selectedCity,
                          onCitySelected: (city) =>
                              setState(() => _selectedCity = city),
                          showError: _submitted && _selectedCity == null,
                        ),

                        SizedBox(height: 24.h),

                        // â”€â”€ Saudi Council Number â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _label(AppStrings.saudiHealthCouncilNumber),
                        CommonTextField(
                          hintText: AppStrings.enterSaudiHealthCouncilNumber,
                          controller: _saudiCouncilCtrl,
                          keyboardType: TextInputType.number,
                          validator: (v) => ValidationUtils.validateRequired(
                            value: v ?? '',
                            fieldName: 'Saudi Health Council number',
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // â”€â”€ Place of Work â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _label(AppStrings.placeOfWork),
                        CommonTextField(
                          hintText: AppStrings.enterPlaceOfWork,
                          controller: _workPlaceCtrl,
                          validator: (v) => ValidationUtils.validateRequired(
                            value: v ?? '',
                            fieldName: 'Place of work',
                          ),
                        ),

                        SizedBox(height: 48.h),

                        // â”€â”€ Register button â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        CommonButton(
                          title: AppStrings.register,
                          isLoading: state.isLoading,
                          onTap: () => _onRegisterPressed(context),
                        ),

                        SizedBox(height: 28.h),

                        // â”€â”€ Login link â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        Center(
                          child: CommonTextButton(
                            title: AppStrings.loginToAccount,
                            onTap: () => Navigator.pushReplacement(
                              context,
                              _fadeSlide(LoginScreen()),
                            ),
                          ),
                        ),

                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // â”€â”€ Helpers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

  Widget _label(String text) => Padding(
    padding: EdgeInsets.only(bottom: 12.h),
    child: Text(text, style: AppTextStyles.labelStyle),
  );

  /// Shows a red error text below a dropdown/city when [show] is true.
  Widget _dropdownError(bool show, String message) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: show
          ? Padding(
              padding: EdgeInsets.only(top: 6.h, left: 4.w),
              child: Text(
                message,
                style: TextStyle(
                  color: AppColors.dangerRed,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  /// Reuses the app-wide fade-slide page transition.
  Route _fadeSlide(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 550),
      reverseTransitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(0.08, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: child,
        ),
      ),
    );
  }
}

// â”€â”€â”€ City selector button â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _CitySelector extends StatelessWidget {
  final String? selectedCity;
  final ValueChanged<String> onCitySelected;
  final bool showError;

  const _CitySelector({
    required this.selectedCity,
    required this.onCitySelected,
    required this.showError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final city = await CityBottomSheet.show(context);
            if (city != null) onCitySelected(city);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 68.h,
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: showError
                    ? Colors.redAccent
                    : selectedCity != null
                    ? AppColors.lightBlue
                    : AppColors.borderColor,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCity ?? AppStrings.enterCity,
                  style: TextStyle(
                    color: selectedCity != null
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.7),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 22.r,
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: showError
              ? Padding(
                  padding: EdgeInsets.only(top: 6.h, left: 4.w),
                  child: Text(
                    AppStrings.cityRequired,
                    style: TextStyle(
                      color: AppColors.dangerRed,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

