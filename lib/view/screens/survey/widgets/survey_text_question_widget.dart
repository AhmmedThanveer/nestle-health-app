import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/survey_models.dart';
import '../../../../view%20model/bloc/survey/survey_bloc.dart';

class SurveyTextQuestionWidget extends StatefulWidget {
  final SurveyQuestion question;
  final String? initialValue;

  const SurveyTextQuestionWidget({
    super.key,
    required this.question,
    required this.initialValue,
  });

  @override
  State<SurveyTextQuestionWidget> createState() =>
      _SurveyTextQuestionWidgetState();
}

class _SurveyTextQuestionWidgetState extends State<SurveyTextQuestionWidget> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.videoCardBg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Question text ───────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.question.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
              ),
              if (widget.question.isRequired)
                Padding(
                  padding: EdgeInsets.only(left: 4.w, top: 2.h),
                  child: Text(
                    '*',
                    style: TextStyle(
                      color: AppColors.dangerRed,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),

          // ── Text area ────────────────────────────────────────────
          TextField(
            controller: _ctrl,
            maxLines: 4,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            onChanged: (val) => context
                .read<SurveyBloc>()
                .add(UpdateAnswerEvent(widget.question.id, val)),
            decoration: InputDecoration(
              hintText: 'Write your answer here...',
              hintStyle: TextStyle(
                color: Colors.white38,
                fontSize: 13.sp,
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.07),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColors.lightBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
