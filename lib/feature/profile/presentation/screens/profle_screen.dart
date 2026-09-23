import 'package:daleeli/core/utils/helper/app_system_ui.dart';
import 'package:daleeli/core/utils/widgets/custom_app_bar.dart';
import 'package:daleeli/feature/profile/presentation/screens/widgets/profile_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile", subtitle: "Your Profile"),
      body:AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
      
        child: ProfileScreenContent())


    );
  }
}