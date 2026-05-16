import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import 'common_button.dart';

abstract final class DisclaimerBottomSheet {
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onAccepted,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _DisclaimerSheet(onAccepted: onAccepted),
    );
  }
}

// ─── Sheet ────────────────────────────────────────────────────────────────────

class _DisclaimerSheet extends StatelessWidget {
  final VoidCallback onAccepted;

  const _DisclaimerSheet({required this.onAccepted});

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Handle ────────────────────────────────────────────────
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // ── Header ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primaryBlue,
                  size: 26.r,
                ),
                SizedBox(width: 10.w),
                Text(
                  'Disclaimer',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          Divider(
            color: AppColors.greyLight,
            thickness: 1,
            height: 1,
          ),

          // ── Scrollable body ───────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
              child: Text(
                _disclaimerText,
                style: TextStyle(
                  color: AppColors.charcoalText,
                  fontSize: 13.5.sp,
                  height: 1.65,
                ),
              ),
            ),
          ),

          // ── Button ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              20.w,
              12.h,
              20.w,
              bottomPad + 20.h,
            ),
            child: CommonButton(
              title: 'I Understand',
              onTap: () {
                Navigator.pop(context);
                onAccepted();
              },
            ),
          ),
        ],
      ),
    );
  }

  static const String _disclaimerText =
      'IMPORTANT INFORMATION: In case of accepting our invitation, '
      'Your workplace (Hospital/Polyclinic/Clinic/Primary health care center/association) '
      'warrants to Nestlé that your participation was permitted and officially authorized '
      'under applicable Law, whereby applicable Law means all, circulars, codes, decrees, '
      'directives, including the Royal Decree No. 49/2004 and the updated Saudi Arabian '
      'code executives regulation of marketing breast milk substitutes issued in the '
      'ministerial decree No. 100493 on 19/2/1440H.\n\n'
      'IMPORTANT NOTICE: We believe that breastfeeding is the ideal nutritional start for '
      'babies, and we fully support the World Health Organizations recommendation of '
      'exclusive breastfeeding for the first six months of life followed by the introduction '
      'of adequate nutritious complementary foods along with continued breastfeeding up to '
      'two years of age. We also recognize that breastfeeding is not always an option for '
      'parents. We recommend healthcare professionals to inform parents about the advantages '
      'of breastfeeding & to educate mothers to start breastfeeding immediately after birth '
      '(within the first hour). A healthy diet is essential to support a healthy pregnancy '
      'and to prepare for and maintain lactation.\n\n'
      'If parents consider not to breastfeed, healthcare professionals should inform parents '
      'that such a decision can be difficult to reverse and that the introduction of partial '
      'bottle-feeding or complementary food before six months of age will reduce the supply '
      'of breast milk. Parents should consider the social, financial, health, & environmental '
      'implications of the use of infant formula. Healthcare professionals should advise the '
      'importance of initiating complementary food at the age of six months, highlighting '
      'that is preferable to prepare complementary foods at home using materials available '
      'to the family in a safe manner. Infant formula and complementary foods should always '
      'be prepared properly when needed whether manufactured industrially or home-prepared '
      'to be used and stored as instructed on the label to avoid risks to a baby\'s health '
      'related to hazards of unnecessary or improper use of infant formula & other breast '
      'milk substitutes as well as hazards related to inappropriate foods or feeding methods. '
      'Healthcare professionals should provide counselling on the proper use of cups, spoons, '
      'other utensils explaining the risks associated with using pacifiers & artificial teats, '
      'ensuring that materials used do not use any pictures or texts that may idealize the '
      'use of breast-milk substitutes.';
}
