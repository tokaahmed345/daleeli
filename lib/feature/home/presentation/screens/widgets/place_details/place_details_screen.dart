import 'package:daleeli/core/utils/helper/app_system_ui.dart';
import 'package:daleeli/feature/home/presentation/screens/widgets/place_details/place_details_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: PlaceDetailsScreenContent()));
  }
}
