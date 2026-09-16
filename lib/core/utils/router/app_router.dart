import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/feature/auth/presentation/screens/login/login_screen.dart';
import 'package:daleeli/feature/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:daleeli/feature/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

abstract final class AppRouter {
  const AppRouter._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return SplashScreen();
          },
        );

      case RoutesName.onBoarding:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return OnBoardingScreen();
          },
        );
         case RoutesName.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return LoginScreen();
          },
        );

      default:
        return null;
    }
  }
}
