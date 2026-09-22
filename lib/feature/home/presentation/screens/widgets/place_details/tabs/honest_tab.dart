import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/core/utils/widgets/app_animation.dart';
import 'package:daleeli/feature/ai_honest_review/presentation/cubit/honest_truth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HonestTruthTabWidget extends StatelessWidget {
  const HonestTruthTabWidget({
    super.key,
    required this.placeName,
    required this.placeDescription,
  });

  final String placeName;
  final String placeDescription;

  @override
  Widget build(BuildContext context) {
    return AppAnimation.detailEntrance(
      delay: 100,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: RepaintBoundary(
          child: BlocBuilder<HonestTruthCubit, HonestTruthState>(
            builder: (context, state) {
              if (state is HonestTruthLoading || state is HonestTruthInitial) {
                return Center(child: const CircularProgressIndicator());
              }

              return Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.08),
                      blurRadius: 10.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12.r,
                          backgroundColor: AppColors.rejectColor,
                          child: Icon(
                            Icons.bolt,
                            size: 14.sp,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "Honest Truth",
                          style: AppStyle.text16.copyWith(
                            color: AppColors.rejectColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    if (state is HonestTruthError) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          "Failed to load AI insights. Pull to refresh.",
                          style: AppStyle.text14.copyWith(
                            color: AppColors.grey600,
                          ),
                        ),
                      ),
                    ] else if (state is HonestTruthLoaded) ...[
                      Builder(
                        builder: (context) {
                          final data = state.entity;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.vibeSummary,
                                style: AppStyle.text14.copyWith(
                                  color: AppColors.charcoal,
                                  height: 1.4,
                                ),
                              ),
                              if (data.bulletPoints.isNotEmpty) ...[
                                Divider(height: 24.h),
                                ...data.bulletPoints.map(
                                  (point) =>
                                      HonestTruthBulletPoint(text: point),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}



class HonestTruthBulletPoint extends StatelessWidget {
  final String text;

  const HonestTruthBulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "– ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.grey600,
              fontSize: 14.sp,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppStyle.text14.copyWith(
                color: AppColors.grey700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
