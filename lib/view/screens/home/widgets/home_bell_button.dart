import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../view%20model/bloc/navigation/navigation_bloc.dart';

class HomeBellButton extends StatelessWidget {
  const HomeBellButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<NavigationBloc>().add(const NavigateToTabEvent(2)),
      child: Container(
        width: 42.r,
        height: 42.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.notifications_outlined, color: Colors.white, size: 22.r),
            Positioned(
              top: 8.r,
              right: 8.r,
              child: Container(
                width: 8.r,
                height: 8.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cyan,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
