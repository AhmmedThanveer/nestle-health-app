import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_textstyles.dart';

class VenueLocationCardWidget extends StatelessWidget {
  final String name;
  final String address;
  final String city;

  const VenueLocationCardWidget({
    super.key,
    required this.name,
    required this.address,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.venueLocation, style: AppTextStyles.venueSectionTitle),
          SizedBox(height: 14.h),
          _InfoRow(
            icon: Icons.domain_rounded,
            child: Text(name, style: AppTextStyles.venueHotelName),
          ),
          SizedBox(height: 10.h),
          _InfoRow(
            icon: Icons.location_on_rounded,
            child: Text(address, style: AppTextStyles.venueInfoText),
          ),
          SizedBox(height: 10.h),
          _InfoRow(
            icon: Icons.location_city_rounded,
            child: Text(city, style: AppTextStyles.venueInfoText),
          ),
        ],
      ),
    );
  }
}

class VenueAboutCardWidget extends StatelessWidget {
  final String auditorium;

  const VenueAboutCardWidget({super.key, required this.auditorium});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.venueAbout, style: AppTextStyles.venueSectionTitle),
          SizedBox(height: 14.h),
          _InfoRow(
            icon: Icons.account_balance_rounded,
            child: Text(auditorium, style: AppTextStyles.venueInfoText),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Widget child;

  const _InfoRow({required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.venueIconColor, size: 20.r),
        SizedBox(width: 10.w),
        Expanded(child: child),
      ],
    );
  }
}
