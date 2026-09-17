import 'package:daleeli/core/utils/assets/app_assets.dart';
import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/core/utils/widgets/custom_elevated_button.dart';
import 'package:daleeli/feature/on_boarding/data/data_source/on_boarding_data.dart';
import 'package:flutter/material.dart';

class OnBoardingScreenContent extends StatefulWidget {
  const OnBoardingScreenContent({super.key});

  @override
  State<OnBoardingScreenContent> createState() =>
      _OnBoardingScreenContentState();
}

class _OnBoardingScreenContentState extends State<OnBoardingScreenContent> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final _pages = OnBoardingData.pages;
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(AppAssets.splash, fit: BoxFit.cover),
        Container(color: AppColors.blackColor.withOpacity(0.93)),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.register);
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: AppColors.whiteColor70),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final page = _pages[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(page.image, height: 250),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            page.title,
                            style: AppStyle.text24,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page.description,
                            style: AppStyle.text14,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentIndex == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? AppColors.whiteColor
                            : Colors.white38,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomElevatedButton(
                    textColor: AppColors.blackColor,
                    backgroundColor: AppColors.primary,
                    onTap: () {
                      if (_currentIndex < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushNamed(context, RoutesName.register);
                      }
                    },

                    text: _pages[_currentIndex].buttonText,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
