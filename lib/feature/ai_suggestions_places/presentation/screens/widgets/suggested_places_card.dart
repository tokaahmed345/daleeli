
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestedPlaceCard extends StatelessWidget {
  final PlacesEntity place;

  const SuggestedPlaceCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.placeDetails, arguments: place);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.accentGold.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: Container(
                    height: 180.h,
                    width: double.infinity,
                    color: AppColors.greyColor,
                    child: CachedNetworkImage(
                      imageUrl: place.imageUrl.trim(),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,

                  left: 12,

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,

                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: AppColors.primary,

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        const Icon(
                          Icons.auto_awesome,

                          color: AppColors.accentGold,

                          size: 14,
                        ),

                        const SizedBox(width: 4),

                        Text(
                          "Custom Recommended",
                          style: AppStyle.text12.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.title,
                              style: AppStyle.text20.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              place.subtitle,
                              style: AppStyle.text14.copyWith(
                                color: AppColors.grey600,
                              ),
                            ),
                            Text(
                              place.description,
                              style: AppStyle.text14.copyWith(
                                color: AppColors.grey600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.accentGold),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              place.rating.toString(),
                              style: AppStyle.text16.copyWith(
                                color: AppColors.accentGold,
                              ),
                            ),
                            Text(
                              "/ 5",
                              style: AppStyle.text12.copyWith(
                                color: AppColors.grey600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.secondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        place.location,
                        style: AppStyle.text14.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
