import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

class CommonDropdownField extends StatelessWidget {
  final String hintText;

  final String? value;

  final List<String> items;

  final Function(String?) onChanged;

  const CommonDropdownField({
    super.key,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,

      padding: EdgeInsets.symmetric(horizontal: 22.w),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),

        border: Border.all(color: Colors.white, width: 1.4),
      ),

      child: DropdownButtonHideUnderline(
        child: Builder(builder: (context) {
          final uniqueItems = items.toSet().toList();
          final safeValue = uniqueItems.contains(value) ? value : null;
          return DropdownButton<String>(
            value: safeValue,
            isExpanded: true,
            dropdownColor: AppColors.dropdownBg,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 28.sp,
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
            ),
            hint: Text(
              hintText,
              style: TextStyle(color: Colors.white70, fontSize: 17.sp),
            ),
            items: uniqueItems
                .map((item) =>
                    DropdownMenuItem<String>(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
          );
        }),
      ),
    );
  }
}
