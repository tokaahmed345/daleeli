import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/feature/ai_suggestions_places/presentation/screens/suggestion_places_screen.dart';
import 'package:daleeli/feature/home/presentation/screens/home_screen.dart';
import 'package:daleeli/feature/saved_place/presentation/cubit/saved_places_cubit.dart';
import 'package:daleeli/feature/saved_place/presentation/screens/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt.get<SavedPlacesCubit>()..fetchSavedPlaces(),
        ),
      ],
      child: const MainNavigationScreenView(),
    );
  }
}

class MainNavigationScreenView extends StatefulWidget {
  const MainNavigationScreenView({super.key});

  @override
  State<MainNavigationScreenView> createState() =>
      _MainNavigationScreenViewState();
}

class _MainNavigationScreenViewState extends State<MainNavigationScreenView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SuggestionPlacesScreen(),
    const SavedScreen(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 2) {
            context.read<SavedPlacesCubit>().fetchSavedPlaces();
          }
        },
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            left: 16.w, 
            right: 16.w,
            child: Container(
              height: 65.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, 
                  children: [
                    CustomNavItem(
                      icon: Icons.home_rounded,
                      label: "Explore",
                      index: 0,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    CustomNavItem(
                      icon: Icons.travel_explore_rounded,
                      label: "Trips",
                      index: 1,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    CustomNavItem(
                      icon: Icons.bookmark_rounded,
                      label: "Saved",
                      index: 2,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    CustomNavItem(
                      icon: Icons.person_rounded,
                      label: "Profile",
                      index: 3,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 4.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.all(isSelected ? 4.r : 0.r),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accentGold.withOpacity(0.25)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppColors.accentGold
                    : AppColors.whiteColor70,
                size: isSelected ? 22.sp : 20.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: AppStyle.text12.copyWith(
                fontSize: 10.sp,
                color: isSelected
                    ? AppColors.accentGold
                    : AppColors.whiteColor70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
