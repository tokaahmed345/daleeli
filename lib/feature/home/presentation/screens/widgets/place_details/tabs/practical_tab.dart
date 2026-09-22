import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/core/utils/widgets/app_animation.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PracticalTabWidget extends StatelessWidget {
  const PracticalTabWidget({super.key, required this.place});
  final PlacesEntity place;
  @override
  Widget build(BuildContext context) {
    return AppAnimation.detailEntrance(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children:  [
            PracticalItemWidget(
              icon: Icons.access_time,
              title: "OPENING HOURS",
              subtitle: place.openingHours,
            ),
            PracticalItemWidget(
              icon: Icons.confirmation_number_outlined,
              title: "ENTRY FEE",
              subtitle: place.entryFee,
            ),
            PracticalItemWidget(
              icon: Icons.place_outlined,
              title: "GOVERNORATE",
              subtitle: place.location,
            ),
          ],
        ),
      ),
    );
  }
}

class PracticalItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const PracticalItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyle.text12.copyWith(
                    color: AppColors.grey600,
                    letterSpacing: 1.1,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: AppStyle.text16.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
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
