import 'package:daleeli/core/utils/assets/app_assets.dart';
import 'package:daleeli/core/utils/widgets/error_state_widget.dart';
import 'package:daleeli/feature/home/presentation/cubit/places_cubit.dart';
import 'package:daleeli/feature/home/presentation/cubit/places_state.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/custom_filter_category.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/places_list.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/places_shimmer_list.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/search_home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            String selectedGov = "All";
            String selectedCat = "All";

            if (state is PlacesLoaded) {
              selectedGov = state.selectedGovernorate;
              selectedCat = state.selectedCategory;
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<PlacesCubit>().fetchPlaces();
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: HomeSearchHeader(),
                  ),
                  SliverToBoxAdapter(
                    child: CustomFiltersSection(
                      selectedGovernorate: selectedGov,
                      selectedCategory: selectedCat,
                      onGovernorateChanged: (gov) {
                        context.read<PlacesCubit>().filterByGovernorate(gov);
                      },
                      onCategoryChanged: (cat) {
                        context.read<PlacesCubit>().filterByCategory(cat);
                      },
                    ),
                  ),
                  
                  if (state is PlacesLoading)
                    const PlacesShimmerList()
                  else if (state is PlacesLoaded)
                    PlacesList(places: state.filteredPlaces)
                  else if (state is PlacesError)
                    SliverFillRemaining(
                      child: ErrorStateWidget(message: state.message),
                    )
                  else
                    const SliverFillRemaining(
                      child: SizedBox.shrink(),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}