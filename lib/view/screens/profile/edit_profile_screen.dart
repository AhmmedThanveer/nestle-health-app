import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/common_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController(text: 'Ahmed Al-Rashidi');
  final _emailCtrl = TextEditingController(text: 'ahmed@example.com');
  final _phoneCtrl = TextEditingController(text: '+966 50 000 0000');
  final _workCtrl = TextEditingController(text: 'King Fahad Hospital');

  String? _selectedCity = 'Riyadh';
  String? _selectedProfession = 'General Practitioner';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _workCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully'),
          backgroundColor: AppColors.primaryBlue,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  colors: [
                    AppColors.primaryBlue.withValues(alpha: 0.97),
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
              children: [
                // ── App bar ────────────────────────────────────────
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white),
                      ),
                      Text(
                        AppStrings.editProfile,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Form ─────────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Avatar
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 90.r,
                                  height: 90.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withValues(alpha: 0.15),
                                    border: Border.all(
                                        color: AppColors.cyan, width: 2.5),
                                  ),
                                  child: Icon(Icons.person_rounded,
                                      size: 48.r, color: Colors.white),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 28.r,
                                    height: 28.r,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryBlue,
                                    ),
                                    child: Icon(Icons.camera_alt_rounded,
                                        size: 16.r, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.h),

                          _EditCard(
                            title: 'Personal Information',
                            children: [
                              _FormField(
                                label: 'Full Name',
                                controller: _nameCtrl,
                                icon: Icons.person_outline_rounded,
                                validator: (v) =>
                                    (v?.trim().isEmpty ?? true) ? 'Required' : null,
                              ),
                              SizedBox(height: 14.h),
                              _FormField(
                                label: AppStrings.email,
                                controller: _emailCtrl,
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                readOnly: true,
                              ),
                              SizedBox(height: 14.h),
                              _FormField(
                                label: AppStrings.mobileNumber,
                                controller: _phoneCtrl,
                                icon: Icons.phone_outlined,
                                keyboardType: TextInputType.phone,
                                validator: (v) =>
                                    (v?.trim().isEmpty ?? true) ? 'Required' : null,
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),

                          _EditCard(
                            title: 'Career Information',
                            children: [
                              _DropdownField(
                                key: ValueKey(_selectedProfession),
                                label: AppStrings.profession,
                                icon: Icons.work_outline_rounded,
                                initialValue: _selectedProfession,
                                items: AppStrings.professionList,
                                onChanged: (v) =>
                                    setState(() => _selectedProfession = v),
                              ),
                              SizedBox(height: 14.h),
                              _DropdownField(
                                key: ValueKey(_selectedCity),
                                label: AppStrings.city,
                                icon: Icons.location_on_outlined,
                                initialValue: _selectedCity,
                                items: AppStrings.saudiCities,
                                onChanged: (v) =>
                                    setState(() => _selectedCity = v),
                              ),
                              SizedBox(height: 14.h),
                              _FormField(
                                label: AppStrings.placeOfWork,
                                controller: _workCtrl,
                                icon: Icons.business_outlined,
                                validator: (v) =>
                                    (v?.trim().isEmpty ?? true) ? 'Required' : null,
                              ),
                            ],
                          ),
                          SizedBox(height: 28.h),

                          CommonButton(
                            title: AppStrings.saveChanges,
                            onTap: _save,
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── White card wrapper ───────────────────────────────────────────────────────

class _EditCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _EditCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.darkNavy,
            ),
          ),
          SizedBox(height: 14.h),
          ...children,
        ],
      ),
    );
  }
}

// ─── Form field ───────────────────────────────────────────────────────────────

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;
  final bool readOnly;
  final String? Function(String?)? validator;

  const _FormField({
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      validator: validator,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14.sp,
        color: readOnly ? Colors.grey : AppColors.darkNavy,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12.sp,
          color: Colors.grey,
        ),
        prefixIcon: Icon(icon, color: AppColors.primaryBlue, size: 20.r),
        filled: true,
        fillColor: readOnly
            ? Colors.grey.shade50
            : AppColors.primaryBlue.withValues(alpha: 0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              BorderSide(color: AppColors.primaryBlue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      ),
    );
  }
}

// ─── Dropdown field ───────────────────────────────────────────────────────────

class _DropdownField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    super.key,
    required this.label,
    required this.icon,
    required this.initialValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: initialValue,
      onChanged: onChanged,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14.sp,
        color: AppColors.darkNavy,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12.sp,
          color: Colors.grey,
        ),
        prefixIcon: Icon(icon, color: AppColors.primaryBlue, size: 20.r),
        filled: true,
        fillColor: AppColors.primaryBlue.withValues(alpha: 0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
              BorderSide(color: AppColors.primaryBlue, width: 1.5),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      ),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
    );
  }
}
