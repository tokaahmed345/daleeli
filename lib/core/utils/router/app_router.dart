import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/core/utils/widgets/main_navigation_screen.dart';
import 'package:daleeli/feature/auth/presentation/screens/login/cubit/login_cubit.dart';
import 'package:daleeli/feature/auth/presentation/screens/login/login_screen.dart';
import 'package:daleeli/feature/auth/presentation/screens/register/cubit/register_cubit.dart';
import 'package:daleeli/feature/auth/presentation/screens/register/screens/register_screen.dart';
import 'package:daleeli/feature/home/presentation/cubit/places_cubit.dart';
import 'package:daleeli/feature/home/presentation/screens/home_screen.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/place_details/place_details_screen.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/search_view_body.dart';
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
            return BlocProvider(
              create: (context) => getIt.get<LoginCubit>(),
              child: LoginScreen(),
            );
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
      case RoutesName.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return HomeScreen();
          },
        );
      case RoutesName.main:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return MainNavigationScreen();
          },
        );
      case RoutesName.placeDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return PlaceDetailsScreen();
          },
        );
      case RoutesName.search:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return BlocProvider(
              create: (context) => getIt.get<PlacesCubit>(),
              child: SearchPlaces(),
            );
          },
        );
      default:
        return null;
    }
  }
}
