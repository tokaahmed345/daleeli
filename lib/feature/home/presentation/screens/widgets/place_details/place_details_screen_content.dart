import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/feature/ai_honest_review/presentation/cubit/honest_truth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:daleeli/core/utils/assets/app_assets.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/place_details/place_details_header.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/place_details/place_tabbar_widgets.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/place_details/tabs/about_tab.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/place_details/tabs/honest_tab.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/place_details/tabs/practical_tab.dart';

class PlaceDetailsScreenContent extends StatefulWidget {
  const PlaceDetailsScreenContent({super.key});

  @override
  State<PlaceDetailsScreenContent> createState() =>
      _PlaceDetailsScreenContentState();
}

class _PlaceDetailsScreenContentState extends State<PlaceDetailsScreenContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)!.settings.arguments as PlacesEntity;

    return BlocProvider(
      create: (context) => getIt<HonestTruthCubit>()
        ..fetchHonestTruth(
          placeName: place.title,
          placeDescription: place.description,
        ),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      PlaceInfoHeaderWidget(places: place),
                      SizedBox(height: 16.h),
                      PlaceTabBarWidget(tabController: _tabController),
                      SizedBox(height: 16.h),

                      SizedBox(
                        height: 400.h,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            AboutTabWidget(place: place),
                            HonestTruthTabWidget(
                              placeName: place.title,
                              placeDescription: place.description,
                            ),
                            PracticalTabWidget(place: place),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.all(16.r),
              //   child: CustomElevatedButton(
              //     text: "Save to my trips",
              //     icon: Icons.bookmark_border,
              //     backgroundColor: AppColors.primary,
              //     textColor: AppColors.whiteColor,
              //     onTap: () {},
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
