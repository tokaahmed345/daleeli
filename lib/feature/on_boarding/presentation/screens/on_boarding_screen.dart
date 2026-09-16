import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/helper/app_system_ui.dart';
import 'package:daleeli/feature/on_boarding/presentation/screens/widgets/on_boarding_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),

        child: OnBoardingScreenContent(),
      ),
    );
  }
}
