import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/core/utils/helper/app_system_ui.dart';
import 'package:daleeli/core/utils/widgets/custom_app_bar.dart';
import 'package:daleeli/feature/ai_suggestions_places/presentation/cubit/ai_suggestion_places_cubit.dart';
import 'package:daleeli/feature/ai_suggestions_places/presentation/screens/widgets/suggestion_places_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestionPlacesScreen extends StatelessWidget {
  const SuggestionPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Trips", subtitle: "SuggestedPlaces"),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: BlocProvider(
          create: (context) =>
              getIt.get<AiSuggestionPlacesCubit>()..getSuggestionsTrips(),
          child: SuggestionPlacesScreenContent(),
        ),
      ),
    );
  }
}
