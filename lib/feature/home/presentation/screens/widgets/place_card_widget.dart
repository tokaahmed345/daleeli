import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/saved_place/presentation/cubit/saved_places_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlaceCardWidget extends StatefulWidget {
  final PlacesEntity place;

  const PlaceCardWidget({super.key, required this.place});

  @override
  State<PlaceCardWidget> createState() => _PlaceCardWidgetState();
}

class _PlaceCardWidgetState extends State<PlaceCardWidget> {
  late bool isSavedLocally;

  @override
  void initState() {
    super.initState();
    isSavedLocally = widget.place.isSaved;
  }

  @override
  void didUpdateWidget(covariant PlaceCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.place.isSaved != widget.place.isSaved) {
      setState(() {
        isSavedLocally = widget.place.isSaved;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutesName.placeDetails,
          arguments: widget.place,
        );
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
                      imageUrl: widget.place.imageUrl.trim(),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(widget.place.category, style: AppStyle.text12),
                  ),
                ),
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: CircleAvatar(
                    backgroundColor: AppColors.warmBeige,
                    child: IconButton(
                      icon: Icon(
                        isSavedLocally ? Icons.bookmark : Icons.bookmark_border,
                        color: isSavedLocally
                            ? AppColors.accentGold
                            : AppColors.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          isSavedLocally = !isSavedLocally;
                        });

                        widget.place.isSaved = isSavedLocally;

                        context.read<SavedPlacesCubit>().toggleSavePlace(
                          widget.place,
                          !isSavedLocally,
                        );
                      },
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
                              widget.place.title,
                              style: AppStyle.text20.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              widget.place.subtitle,
                              style: AppStyle.text14.copyWith(
                                color: AppColors.grey600,
                              ),
                            ),
                            Text(
                              widget.place.description,
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
                              widget.place.rating.toString(),
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
                        widget.place.location,
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
