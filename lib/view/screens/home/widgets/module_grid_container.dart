import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/home_module_data.dart';
import 'home_module_card.dart';

class ModuleGridContainer extends StatelessWidget {
  final void Function(String route) onModuleTap;

  const ModuleGridContainer({super.key, required this.onModuleTap});

  @override
  Widget build(BuildContext context) {
    final double navBarOffset = 92.h + MediaQuery.of(context).padding.bottom;

    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.r),
            topRight: Radius.circular(28.r),
          ),

          border: Border.all(color: AppColors.glassBorder, width: 1.2),

          color: AppColors.glassBg,
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.r),
            topRight: Radius.circular(28.r),
          ),

          child: GridView.builder(
            physics: const BouncingScrollPhysics(),

            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, navBarOffset),

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,

              mainAxisSpacing: 18.h,

              crossAxisSpacing: 8.w,

              childAspectRatio: 0.82,
            ),

            itemCount: HomeModuleData.all.length,

            cacheExtent: 1200,

            itemBuilder: (context, index) {
              final module = HomeModuleData.all[index];

              return RepaintBoundary(
                child: HomeModuleCard(
                  data: module,

                  index: index,

                  onTap: () => onModuleTap(module.route),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
