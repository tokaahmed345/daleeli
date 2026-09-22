import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/core/utils/widgets/app_animation.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutTabWidget extends StatelessWidget {
  const AboutTabWidget({super.key, required this.place});
final PlacesEntity place;
  @override
  Widget build(BuildContext context) {
    return AppAnimation.detailEntrance(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Text(
      place.description,
          style: AppStyle.text16.copyWith(
            color: AppColors.charcoal,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
