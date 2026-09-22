import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFiltersSection extends StatelessWidget {
  final String selectedGovernorate;
  final String selectedCategory;
  final Function(String) onGovernorateChanged;
  final Function(String) onCategoryChanged;

  const CustomFiltersSection({
    super.key,
    required this.selectedGovernorate,
    required this.selectedCategory,
    required this.onGovernorateChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> governorates = ["All", "Cairo", "Luxor", "Aswan", "Matrouh"];
    final List<String> categories = ["All", "Monuments", "Markets", "Nature", "Museums"];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text("GOVERNORATE", style: AppStyle.text12.copyWith(color: AppColors.grey600, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              itemCount: governorates.length,
              itemBuilder: (context, index) {
                bool isSelected = governorates[index] == selectedGovernorate;
                return GestureDetector(
                  onTap: () => onGovernorateChanged(governorates[index]),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.accentGold.withOpacity(0.4)),
                    ),
                    child: Text(
                      governorates[index],
                      style: AppStyle.text14.copyWith(
                        color: isSelected ? AppColors.whiteColor : AppColors.primary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                bool isSelected = categories[index] == selectedCategory;
                return GestureDetector(
                  onTap: () => onCategoryChanged(categories[index]),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.accentGold.withOpacity(0.4)),
                    ),
                    child: Text(
                      categories[index],
                      style: AppStyle.text14.copyWith(
                        color: isSelected ? AppColors.whiteColor : AppColors.primary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}