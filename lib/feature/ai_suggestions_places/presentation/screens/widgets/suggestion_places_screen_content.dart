import 'package:daleeli/core/utils/assets/app_assets.dart';
import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/feature/ai_suggestions_places/presentation/cubit/ai_suggestion_places_cubit.dart';
import 'package:daleeli/feature/ai_suggestions_places/presentation/screens/widgets/suggested_places_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SuggestionPlacesScreenContent extends StatelessWidget {
  const SuggestionPlacesScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocBuilder<AiSuggestionPlacesCubit, AiSuggestionPlacesState>(
        builder: (context, state) {
          if (state is AiSuggestionPlacesLoading) {
            return Center(
              child: const SizedBox(
                width: 26,
                height: 26,
                child: SpinKitWanderingCubes(
                  color: AppColors.primary,
                  size: 24.0,
                ),
              ),
            );
          } else if (state is AiSuggestionPlacesFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  state.meessage,
                  style: AppStyle.text16.copyWith(color: AppColors.rejectColor),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (state is AiSuggestionPlacesSuccess) {
            final places = state.trips;

            if (places.isEmpty) {
              return Center(
                child: Text(
                  "No Suggested Places Available",
                  style: AppStyle.text18.copyWith(color: AppColors.primary),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: places.length,
              itemBuilder: (context, index) {
                return SuggestedPlaceCard(place: places[index]);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
