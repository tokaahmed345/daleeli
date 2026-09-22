import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/feature/home/domain/entity/places_entity.dart';
import 'package:daleeli/feature/home/presentation/cubit/places_cubit.dart';
import 'package:daleeli/feature/home/presentation/cubit/places_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPlaces extends StatefulWidget {
  const SearchPlaces({super.key});

  @override
  State<SearchPlaces> createState() => _SearchPlacesState();
}

class _SearchPlacesState extends State<SearchPlaces> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  @override
  void initState() {
    context.read<PlacesCubit>().fetchPlaces();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
        ),
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _controller,
          autofocus: true,
          style: TextStyle(color: AppColors.approveLightBg),
          decoration: const InputDecoration(
            hintText: 'Search by Places...',
            border: InputBorder.none,

            hintStyle: TextStyle(color: AppColors.approveLightBg),
          ),
          onChanged: (value) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(Duration(milliseconds: 500), () {
              context.read<PlacesCubit>().searchByTitle(value);
            });
          },
        ),
      ),
      body: BlocBuilder<PlacesCubit, PlacesState>(
        builder: (context, state) {
          if (state is PlacesError) {
            return Center(child: Text(state.message));
          }

          if (state is PlacesLoaded) {
            if (_controller.text.trim().isEmpty) {
              return const Center(
                child: Text(
                  'Start typing to search for places...',
                  style: TextStyle(color: AppColors.greyColor, fontSize: 16),
                ),
              );
            }

            if (state.filteredPlaces.isEmpty) {
              return const Center(child: Text('No Places found'));
            }

            return ListView.builder(
              itemCount: state.filteredPlaces.length,
              itemBuilder: (context, index) {
                final PlacesEntity places = state.filteredPlaces[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: places.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                        errorWidget: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                  title: Text(places.title),
                  subtitle: Text(places.category),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.placeDetails,
                      arguments: places,
                    );
                  },
                );
              },
            );
          }

          return const Center(child: Text('Search for a Place...'));
        },
      ),
    );
  }
}
