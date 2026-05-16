import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/common_button.dart';

class CityBottomSheet {
  static Future<String?> show(BuildContext context, {String? initialCity}) async {
    String? selectedCity = initialCity;

    final Map<String, List<String>> cityRegions = {
      AppStrings.westernRegion: [
        'Jeddah',
        'Mecca',
        'Medina',
        'Taif',
        'Yanbu',
        'Rabigh',
      ],

      AppStrings.centralRegion: [
        'Riyadh',
        'Al Kharj',
        'Al Majmaah',
        'Al Qassim',
      ],

      AppStrings.easternRegion: [
        'Dammam',
        'Khobar',
        'Dhahran',
        'Jubail',
        'Al Ahsa',
      ],

      AppStrings.southernRegion: [
        'Abha',
        'Khamis Mushait',
        'Jazan',
        'Najran',
        'Al Baha',
      ],

      AppStrings.northernRegion: [
        'Tabuk',
        'Hail',
        'Arar',
        'Sakaka',
        'Qurayyat',
      ],
    };

    return await showModalBottomSheet<String>(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.transparent,

      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.82,

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.vertical(top: Radius.circular(34.r)),
              ),

              child: Column(
                children: [
                  SizedBox(height: 10.h),

                  /// TOP HANDLE
                  Container(
                    width: 52.w,

                    height: 5.h,

                    decoration: BoxDecoration(
                      color: AppColors.greyMid,

                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// HEADER
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          AppStrings.city,

                          style: TextStyle(
                            fontSize: 24.sp,

                            fontWeight: FontWeight.w700,

                            color: Colors.black,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },

                          child: Icon(
                            Icons.close,

                            size: 30.sp,

                            color: AppColors.greyText,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 18.h),

                  /// CITY LIST
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),

                      child: Column(
                        children: cityRegions.entries.map((region) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              /// REGION TITLE
                              Container(
                                width: double.infinity,

                                padding: EdgeInsets.symmetric(
                                  horizontal: 22.w,
                                  vertical: 14.h,
                                ),

                                color: AppColors.regionHeaderBg,

                                child: Text(
                                  region.key,

                                  style: TextStyle(
                                    fontSize: 16.sp,

                                    fontWeight: FontWeight.w700,

                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              /// CITY ITEMS
                              ...region.value.map(
                                (city) => GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      selectedCity = city;
                                    });
                                  },

                                  child: Container(
                                    width: double.infinity,

                                    padding: EdgeInsets.symmetric(
                                      horizontal: 22.w,
                                      vertical: 18.h,
                                    ),

                                    color: selectedCity == city
                                        ? AppColors.lightBlue.withOpacity(0.10)
                                        : Colors.white,

                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            city,

                                            style: TextStyle(
                                              fontSize: 15.sp,

                                              fontWeight: FontWeight.w500,

                                              color: Colors.black,
                                            ),
                                          ),
                                        ),

                                        if (selectedCity == city)
                                          Icon(
                                            Icons.check_circle,

                                            color: AppColors.lightBlue,

                                            size: 20.sp,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  /// CONFIRM BUTTON
                  Padding(
                    padding: EdgeInsets.fromLTRB(22.w, 16.h, 22.w, 28.h),

                    child: CommonButton(
                      title: AppStrings.confirm,

                      onTap: () {
                        Navigator.pop(context, selectedCity);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
