import 'package:daleeli/core/utils/assets/app_assets.dart';
import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/feature/saved_place/presentation/cubit/saved_places_cubit.dart';
import 'package:daleeli/feature/saved_place/presentation/screens/widgets/saved_place_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedScreenContent extends StatelessWidget {
  const SavedScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "SAVED PLACES",
                  style: AppStyle.text14.copyWith(
                    color: AppColors.grey600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: BlocBuilder<SavedPlacesCubit, SavedPlacesState>(
                builder: (context, state) {
                  if (state is SavedLoading) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    );
                  } else if (state is SavedPlacesLoaded) {
                    final places = state.savedPlaces;

                    if (places.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Text(
                            "No saved places yet.",
                            style: AppStyle.text16.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return SavedPlaceCardWidget(place: places[index]);
                      }, childCount: places.length),
                    );
                  } else if (state is SavedError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          state.message,
                          style: AppStyle.text16.copyWith(
                            color: AppColors.redColor,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
