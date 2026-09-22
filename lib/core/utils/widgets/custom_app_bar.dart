import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final Widget? trailingIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: AppStyle.text12.copyWith(color: AppColors.whiteColor70)),
              SizedBox(height: 2.h),
              Text(subtitle, style: AppStyle.text24),
            ],
          ),
          trailingIcon ??
              Container(
                width: 42.w,
                height: 42.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.whiteColor70.withOpacity(0.3)),
                ),
                child: const Icon(Icons.change_history, color: AppColors.whiteColor70),
              ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}