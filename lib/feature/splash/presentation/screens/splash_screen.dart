import 'package:daleeli/core/utils/helper/app_system_ui.dart';
import 'package:daleeli/feature/splash/presentation/screens/widgets/splash_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),

        child: SplashScreenContent(),
      ),
    );
  }
}
