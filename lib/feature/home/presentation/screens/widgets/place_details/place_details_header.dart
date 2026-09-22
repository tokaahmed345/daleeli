import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceInfoHeaderWidget extends StatelessWidget {
  const PlaceInfoHeaderWidget({super.key, required this.places});
  final PlacesEntity places;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child:
                    places.imageUrl.isNotEmpty &&
                        places.imageUrl != 'YOUR_IMAGE_URL'
                    ? Image.network(
                        places.imageUrl,
                        height: 250.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : const Center(
                        child: Icon(
                          Icons.image,
                          color: AppColors.whiteColor,
                          size: 50,
                        ),
                      ),
              ).animate().fadeIn(duration: 500.ms),

              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.warmBeige.withOpacity(0.8),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    // CircleAvatar(
                    //   backgroundColor: AppColors.warmBeige.withOpacity(0.8),
                    //   child: IconButton(
                    //     icon: const Icon(
                    //       Icons.bookmark,
                    //       size: 18,
                    //       color: AppColors.primary,
                    //     ),
                    //     onPressed: () {},
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      places.title,
                      style: AppStyle.text28.copyWith(color: AppColors.primary),
                    ),
                    Text(
                      places.subtitle,
                      style: AppStyle.text18.copyWith(
                        color: AppColors.primary.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: AppColors.grey600,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          places.location,
                          style: AppStyle.text14.copyWith(
                            color: AppColors.grey600,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.greyColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            places.category,
                            style: AppStyle.text12.copyWith(
                              color: AppColors.charcoal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Text(
                      places.rating.toString(),
                      style: AppStyle.text20.copyWith(color: AppColors.primary),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 12.sp,
                          color: AppColors.accentGold,
                        ),
                      ),
                    ),
                    Text(
                      "Rating",
                      style: AppStyle.text12.copyWith(color: AppColors.grey600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
