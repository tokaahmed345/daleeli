import 'package:daleeli/core/utils/widgets/custom_app_bar.dart';
import 'package:daleeli/feature/saved_place/presentation/screens/widgets/saved_screen_content.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      appBar: CustomAppBar(title: "Intersted Places", subtitle: "Saved Places"),
      body: SavedScreenContent(),
    );
  }
}
