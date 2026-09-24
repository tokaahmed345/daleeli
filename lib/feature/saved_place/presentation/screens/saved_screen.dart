import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/core/utils/widgets/custom_app_bar.dart';
import 'package:daleeli/feature/saved_place/presentation/cubit/saved_places_cubit.dart';
import 'package:daleeli/feature/saved_place/presentation/screens/widgets/saved_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Intersted Places", subtitle: "Saved Places"),
      body: BlocProvider(
        create: (context) =>               getIt.get<SavedPlacesCubit>()..fetchSavedPlaces(),

        child: SavedScreenContent(),
      ),
    );
  }
}
