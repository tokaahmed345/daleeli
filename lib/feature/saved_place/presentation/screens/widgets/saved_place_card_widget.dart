
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedPlaceCardWidget extends StatelessWidget {
  final PlacesEntity place;

  const SavedPlaceCardWidget({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        RoutesName.placeDetails,
        arguments: place,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(
                width: 55.w,
                height: 55.h,
                child: CachedNetworkImage(
                  imageUrl: place.imageUrl.trim(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: AppColors.greyColor),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: AppColors.redColor),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.title,
                    style: AppStyle.text18.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "${place.location} · ${place.category}",
                    style: AppStyle.text12.copyWith(color: AppColors.secondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    place.description,
                    style: AppStyle.text12.copyWith(
                      color: AppColors.grey700,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.grey600),
          ],
        ),
      ),
    );
  }
}