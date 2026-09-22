
import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceTabBarWidget extends StatelessWidget {
  final TabController tabController;

  const PlaceTabBarWidget({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.grey600,
      indicatorColor: AppColors.primary,
      indicatorWeight: 3.h,
      labelStyle: AppStyle.text16.copyWith(fontWeight: FontWeight.bold),
      tabs: const [
        Tab(text: "About"),
        Tab(text: "Honest Truth"),
        Tab(text: "Practical"),
      ],
    );
  }
}
