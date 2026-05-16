import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../view%20model/bloc/auth/auth_bloc.dart';
import '../../../view%20model/bloc/auth/auth_event.dart';
import '../../../view%20model/bloc/auth/auth_state.dart';
import '../../../view%20model/bloc/profile/profile_bloc.dart';
import '../../widgets/animated_entrance_item.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/logout_confirmation_dialog.dart';
import '../../widgets/nestle_logo_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadProfile());
  }

  void _loadProfile() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticatedState) {
      context.read<ProfileBloc>().add(LoadProfileEvent(authState.user.uid));
    }
  }

  Future<void> _onRefresh() async {
    _loadProfile();
    await Future.delayed(const Duration(milliseconds: 800));
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
                    AppColors.primaryBlue.withValues(alpha: 0.85),
                    AppColors.primaryBlue.withValues(alpha: 0.60),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state.status == ProfileStatus.loading &&
                    state.user == null) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                return Column(
                  children: [
                    const NestleLogoWidget(),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _onRefresh,
                        color: AppColors.primaryBlue,
                        backgroundColor: Colors.white,
                        child: ListView(
                          padding: EdgeInsets.fromLTRB(
                            16.w,
                            0,
                            16.w,
                            80.h + MediaQuery.of(context).padding.bottom,
                          ),
                          children: [
                            AnimatedEntranceItem(
                              direction: EntranceDirection.rtl,
                              index: 0,
                              child: _PointsCard(points: state.user?.points ?? 0),
                            ),
                            SizedBox(height: 14.h),
                            AnimatedEntranceItem(
                              direction: EntranceDirection.rtl,
                              index: 1,
                              child: _ContactInfoCard(user: state.user),
                            ),
                            SizedBox(height: 14.h),
                            AnimatedEntranceItem(
                              direction: EntranceDirection.rtl,
                              index: 2,
                              child: _CareerInfoCard(user: state.user),
                            ),
                            SizedBox(height: 20.h),
                            AnimatedEntranceItem(
                              direction: EntranceDirection.rtl,
                              index: 3,
                              child: _ActionButton(
                                icon: Icons.edit_outlined,
                                label: AppStrings.editProfile,
                                onTap: () => Navigator.pushNamed(context, AppRoutes.editProfile),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            AnimatedEntranceItem(
                              direction: EntranceDirection.rtl,
                              index: 4,
                              child: _ActionButton(
                                icon: Icons.badge_outlined,
                                label: 'Name Tag',
                                onTap: () => Navigator.pushNamed(context, AppRoutes.nameTag),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            AnimatedEntranceItem(
                              direction: EntranceDirection.rtl,
                              index: 5,
                              child: _ActionButton(
                                icon: Icons.lock_outline_rounded,
                                label: 'Change Password',
                                onTap: () => Navigator.pushNamed(context, AppRoutes.changePassword),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            AnimatedEntranceItem(
                              direction: EntranceDirection.rtl,
                              index: 6,
                              child: _ActionButton(
                                icon: Icons.logout_rounded,
                                label: AppStrings.logout,
                                onTap: () async {
                                  final confirmed =
                                      await LogoutConfirmationDialog.show(context);
                                  if (!confirmed || !context.mounted) return;
                                  context.read<AuthBloc>().add(SignOutEvent());
                                  AppSnackBar.showSuccess(context, 'Logged out successfully.');
                                },
                              ),
                            ),
                            SizedBox(height: 10.h),
                            AnimatedEntranceItem(
                              direction: EntranceDirection.rtl,
                              index: 6,
                              child: _ActionButton(
                                icon: Icons.delete_outline_rounded,
                                label: AppStrings.deleteAccount,
                                isDestructive: true,
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Points card ─────────────────────────────────────────────────────────────

class _PointsCard extends StatelessWidget {
  final int points;
  const _PointsCard({required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.star_rounded,
              color: AppColors.primaryBlue,
              size: 26.r,
            ),
          ),
          SizedBox(width: 14.w),
          Text(
            'Points',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.darkNavy,
            ),
          ),
          const Spacer(),
          Text(
            '$points',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.darkNavy,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Contact info card ────────────────────────────────────────────────────────

class _ContactInfoCard extends StatelessWidget {
  final UserEntity? user;
  const _ContactInfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Contact Information',
      items: [
        _InfoItem(
          icon: Icons.person_rounded,
          label: 'Name',
          value: user?.fullName ?? '—',
        ),
        _InfoItem(
          icon: Icons.email_rounded,
          label: 'Email',
          value: user?.email ?? '—',
        ),
        _InfoItem(
          icon: Icons.phone_rounded,
          label: 'Phone',
          value: user?.mobile ?? '—',
        ),
        _InfoItem(
          icon: Icons.location_on_rounded,
          label: 'City',
          value: user?.city ?? '—',
        ),
      ],
    );
  }
}

// ─── Career info card ─────────────────────────────────────────────────────────

class _CareerInfoCard extends StatelessWidget {
  final UserEntity? user;
  const _CareerInfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Career Information',
      items: [
        _InfoItem(
          icon: Icons.work_rounded,
          label: 'Profession',
          value: user?.profession ?? '—',
        ),
        _InfoItem(
          icon: Icons.business_rounded,
          label: 'Place of Work',
          value: user?.workplace ?? '—',
        ),
        _InfoItem(
          icon: Icons.badge_rounded,
          label: 'Saudi Health Council No.',
          value: user?.saudiCouncilNumber ?? '—',
        ),
      ],
    );
  }
}

// ─── Info card ────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final String title;
  final List<_InfoItem> items;

  const _InfoCard({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.darkNavy,
            ),
          ),
          SizedBox(height: 14.h),
          ...items.expand(
            (item) => [
              _InfoRow(item: item),
              if (item != items.last)
                Divider(height: 18.h, color: Colors.grey.shade100),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}

class _InfoRow extends StatelessWidget {
  final _InfoItem item;
  const _InfoRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42.r,
          height: 42.r,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(item.icon, color: AppColors.primaryBlue, size: 22.r),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 11.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                item.value,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkNavy,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Action button ────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isDestructive
        ? Colors.red.shade600
        : AppColors.primaryBlue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22.r),
            SizedBox(width: 14.w),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: color.withValues(alpha: 0.5),
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}
