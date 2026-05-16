import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../view%20model/bloc/auth/auth_bloc.dart';
import '../../../view%20model/bloc/auth/auth_state.dart';
import '../../../view%20model/bloc/profile/profile_bloc.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/city_bottomsheet.dart';
import '../../widgets/common_button.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _fullNameCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();

  String? _selectedProfession;
  String? _selectedTopic;
  String? _selectedCity;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    final user = context.read<ProfileBloc>().state.user;
    if (user != null) {
      _fullNameCtrl.text = user.fullName;
      _mobileCtrl.text = user.mobile;
      _selectedProfession = AppStrings.professionList.contains(user.profession)
          ? user.profession
          : null;
      _selectedTopic = AppStrings.secondaryTopicsList.contains(user.selectedTopic)
          ? user.selectedTopic
          : null;
      _selectedCity =
          AppStrings.saudiCities.contains(user.city) ? user.city : null;
    }
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _mobileCtrl.dispose();
    super.dispose();
  }

  void _save() {
    FocusScope.of(context).unfocus();
    final fullName = _fullNameCtrl.text.trim();
    final mobile = _mobileCtrl.text.trim();

    if (fullName.isEmpty) {
      AppSnackBar.showError(context, 'Please enter your full name.');
      return;
    }
    if (mobile.isEmpty) {
      AppSnackBar.showError(context, 'Please enter your mobile number.');
      return;
    }
    if (_selectedProfession == null) {
      AppSnackBar.showError(context, 'Please select your profession.');
      return;
    }
    if (_selectedCity == null) {
      AppSnackBar.showError(context, 'Please select your city.');
      return;
    }

    final parts = fullName.split(' ');
    final firstName = parts.first;
    final familyName = parts.length > 1 ? parts.skip(1).join(' ') : '';

    final user = context.read<ProfileBloc>().state.user;
    if (user == null) return;

    final authState = context.read<AuthBloc>().state;
    final uid = authState is AuthAuthenticatedState
        ? authState.user.uid
        : user.uid;

    context.read<ProfileBloc>().add(
          UpdateProfileEvent(
            uid: uid,
            firstName: firstName,
            familyName: familyName,
            mobile: mobile,
            profession: _selectedProfession!,
            city: _selectedCity!,
            workplace: user.workplace,
            saudiCouncilNumber: user.saudiCouncilNumber,
            selectedTopic: _selectedTopic,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status &&
          (curr.status == ProfileStatus.updated ||
              curr.status == ProfileStatus.error),
      listener: (context, state) {
        if (state.status == ProfileStatus.updated) {
          AppSnackBar.showSuccess(context, 'Profile updated successfully.');
          Navigator.pop(context);
        } else if (state.status == ProfileStatus.error &&
            state.errorMessage != null) {
          AppSnackBar.showError(context, state.errorMessage!);
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
                  const ModuleAppBar(title: 'Edit Profile'),
                  Expanded(
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      buildWhen: (prev, curr) =>
                          prev.status != curr.status,
                      builder: (context, state) {
                        final isUpdating =
                            state.status == ProfileStatus.updating;
                        return _EditProfileBody(
                          fullNameCtrl: _fullNameCtrl,
                          mobileCtrl: _mobileCtrl,
                          selectedProfession: _selectedProfession,
                          selectedTopic: _selectedTopic,
                          selectedCity: _selectedCity,
                          isLoading: isUpdating,
                          onProfessionChanged: (v) =>
                              setState(() => _selectedProfession = v),
                          onTopicChanged: (v) =>
                              setState(() => _selectedTopic = v),
                          onCityChanged: (v) =>
                              setState(() => _selectedCity = v),
                          onSave: _save,
                        );
                      },
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

// â”€â”€â”€ Body â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _EditProfileBody extends StatelessWidget {
  final TextEditingController fullNameCtrl;
  final TextEditingController mobileCtrl;
  final String? selectedProfession;
  final String? selectedTopic;
  final String? selectedCity;
  final bool isLoading;
  final ValueChanged<String?> onProfessionChanged;
  final ValueChanged<String?> onTopicChanged;
  final ValueChanged<String?> onCityChanged;
  final VoidCallback onSave;

  const _EditProfileBody({
    required this.fullNameCtrl,
    required this.mobileCtrl,
    required this.selectedProfession,
    required this.selectedTopic,
    required this.selectedCity,
    required this.isLoading,
    required this.onProfessionChanged,
    required this.onTopicChanged,
    required this.onCityChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
            children: [
              const NestleLogoWidget(topPadding: 0),
              SizedBox(height: 28.h),

              // Full Name
              _FieldLabel(AppStrings.firstName.replaceFirst('First ', 'Full ')),
              SizedBox(height: 8.h),
              _ProfileTextField(
                controller: fullNameCtrl,
                hint: 'Enter your full name',
              ),
              SizedBox(height: 20.h),

              // Mobile Number
              _FieldLabel(AppStrings.mobileNumber),
              SizedBox(height: 8.h),
              _ProfileTextField(
                controller: mobileCtrl,
                hint: AppStrings.enterMobileNumber,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20.h),

              // Profession
              _FieldLabel(AppStrings.profession),
              SizedBox(height: 8.h),
              _ProfileDropdown(
                value: selectedProfession,
                hint: AppStrings.enterProfession,
                items: AppStrings.professionList,
                onChanged: onProfessionChanged,
              ),
              SizedBox(height: 20.h),

              // Second Day Topics
              _FieldLabel(AppStrings.secondaryTopics),
              SizedBox(height: 8.h),
              _ProfileDropdown(
                value: selectedTopic,
                hint: AppStrings.enterSecondaryTopics,
                items: AppStrings.secondaryTopicsList,
                onChanged: onTopicChanged,
              ),
              SizedBox(height: 20.h),

              // City â€” opens grouped bottom sheet
              _FieldLabel(AppStrings.city),
              SizedBox(height: 8.h),
              _CityField(
                selectedCity: selectedCity,
                onCityChanged: onCityChanged,
              ),
              SizedBox(height: 8.h),
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
            title: AppStrings.saveChanges,
            isLoading: isLoading,
            onTap: isLoading ? null : onSave,
          ),
        ),
      ],
    );
  }
}

// â”€â”€â”€ Label â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

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
        fontFamily: 'Montserrat',
      ),
    );
  }
}

// â”€â”€â”€ Profile text field â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;

  const _ProfileTextField({
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
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
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
        cursorColor: Colors.white,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColors.hintColor,
            fontSize: 16.sp,
            fontFamily: 'Montserrat',
          ),
          isCollapsed: true,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
        ),
      ),
    );
  }
}

// â”€â”€â”€ Profile dropdown â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

// â”€â”€â”€ City field â€” opens CityBottomSheet â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _CityField extends StatelessWidget {
  final String? selectedCity;
  final ValueChanged<String?> onCityChanged;

  const _CityField({required this.selectedCity, required this.onCityChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final city = await CityBottomSheet.show(context);
        if (city != null) onCityChanged(city);
      },
      child: Container(
        height: 68.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedCity ?? AppStrings.enterCity,
                style: TextStyle(
                  color: selectedCity != null
                      ? Colors.white
                      : AppColors.hintColor,
                  fontSize: selectedCity != null ? 18.sp : 16.sp,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.white70, size: 22.r),
          ],
        ),
      ),
    );
  }
}

// â”€â”€â”€ Profile dropdown â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _ProfileDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _ProfileDropdown({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor, width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            hint,
            style: TextStyle(
              color: AppColors.hintColor,
              fontSize: 16.sp,
              fontFamily: 'Montserrat',
            ),
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
          ),
          dropdownColor: AppColors.primaryBlue,
          iconEnabledColor: Colors.white70,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          onChanged: onChanged,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

