import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/feature/auth/presentation/screens/login/login_screen.dart';
import 'package:daleeli/feature/auth/presentation/screens/register/cubit/register_cubit.dart';
import 'package:daleeli/feature/auth/presentation/screens/register/screens/register_screen.dart';
import 'package:daleeli/feature/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:daleeli/feature/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

      case RoutesName.register:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return BlocProvider(
              create: (context) => getIt.get<RegisterCubit>(),
              child: RegisterScreen(),
            );
          },
        );
      default:
        return null;
    }
  }
}
