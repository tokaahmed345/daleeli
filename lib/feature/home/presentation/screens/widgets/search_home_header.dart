import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/core/utils/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchHeader extends StatelessWidget {
  const HomeSearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(
            title: "DALEELI",
            subtitle: "Where to, traveller?",
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.warmBeige,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                readOnly: true,
                onTap: () => Navigator.pushNamed(context, RoutesName.search),
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, color: AppColors.grey600),
                  hintText: "Search places, governorates...",
                  hintStyle: AppStyle.text14.copyWith(color: AppColors.grey600),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
