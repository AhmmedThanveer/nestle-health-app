import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../view%20model/bloc/profile/profile_bloc.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';

class NameTagScreen extends StatelessWidget {
  const NameTagScreen({super.key});

  @override
  Widget build(BuildContext context) => const _NameTagView();
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _NameTagView extends StatelessWidget {
  const _NameTagView();

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
                  stops: const [0.0, 0.3, 0.6, 1.0],
                  colors: [
                    AppColors.primaryBlue.withValues(alpha: 1.0),
                    AppColors.primaryBlue.withValues(alpha: 0.95),
                    AppColors.primaryBlue.withValues(alpha: 0.80),
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
                const ModuleAppBar(title: 'Name Tag'),
                Expanded(
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state.status == ProfileStatus.loading &&
                          state.user == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white),
                        );
                      }
                      final user = state.user;
                      if (user == null) {
                        return Center(
                          child: Text(
                            'Profile not available.',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 15.sp),
                          ),
                        );
                      }
                      return _NameTagContent(
                        uid: user.uid,
                        fullName: user.fullName,
                        selectedTopic: user.selectedTopic,
                        profession: user.profession,
                      );
                    },
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

// ─── Content ──────────────────────────────────────────────────────────────────

class _NameTagContent extends StatelessWidget {
  final String uid;
  final String fullName;
  final String? selectedTopic;
  final String profession;

  const _NameTagContent({
    required this.uid,
    required this.fullName,
    required this.selectedTopic,
    required this.profession,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
      child: Column(
        children: [
          const NestleLogoWidget(topPadding: 0),
          SizedBox(height: 20.h),

          // Name tag card
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
            decoration: BoxDecoration(
              color: AppColors.glassBg,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: AppColors.glassBorder, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Avatar circle with initials
                _AvatarInitials(name: fullName),
                SizedBox(height: 16.h),

                // Full name
                Text(
                  fullName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: 6.h),

                // Profession
                if (profession.isNotEmpty)
                  Text(
                    profession,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 13.sp,
                    ),
                  ),

                // Selected topic chip
                if (selectedTopic != null && selectedTopic!.isNotEmpty) ...[
                  SizedBox(height: 14.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.cyan.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                          color: AppColors.cyan.withValues(alpha: 0.5),
                          width: 1.0),
                    ),
                    child: Text(
                      selectedTopic!,
                      style: TextStyle(
                        color: AppColors.cyan,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],

                SizedBox(height: 28.h),

                // QR code
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: QrImageView(
                    data: uid,
                    version: QrVersions.auto,
                    size: 180.r,
                    backgroundColor: Colors.white,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Color(0xFF005EA8),
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Color(0xFF005EA8),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),
                Text(
                  'Scan to verify attendance',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12.sp,
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

// ─── Avatar initials ──────────────────────────────────────────────────────────

class _AvatarInitials extends StatelessWidget {
  final String name;
  const _AvatarInitials({required this.name});

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first.isNotEmpty ? parts.first[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.r,
      height: 72.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.cyan.withValues(alpha: 0.8),
            AppColors.primaryBlue.withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.cyan, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withValues(alpha: 0.25),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          _initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
