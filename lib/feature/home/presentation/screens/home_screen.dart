import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/core/utils/helper/app_system_ui.dart';
import 'package:daleeli/feature/home/presentation/cubit/places_cubit.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/home_screen_content.dart';
import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: BlocProvider(
          create: (context) => getIt.get<PlacesCubit>()..fetchPlaces(),
          child: const HomeScreenContent(),
        ),
      ),
    );
  }
}
