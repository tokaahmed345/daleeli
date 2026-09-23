import 'package:daleeli/core/utils/assets/app_assets.dart';
import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/core/utils/widgets/custom_elevated_button.dart';
import 'package:daleeli/feature/profile/presentation/screens/widgets/profile_menu_card.dart';
import 'package:flutter/material.dart';

class ProfileScreenContent extends StatelessWidget {
  const ProfileScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // User Avatar & Info Header
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.accentGold,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Toka Ahmed',
                    style: AppStyle.text20.copyWith(
                      color: AppColors.charcoal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'toka.ahmed@example.com',
                    style: AppStyle.text14.copyWith(color: AppColors.grey700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            ProfileMenuCard(
              icon: Icons.headset_mic_outlined,
              title: 'Help & Support',
              subtitle: 'Contact us for any issue',
              onTap: () {},
            ),

            ProfileMenuCard(
              icon: Icons.share_outlined,
              title: 'Share App',
              subtitle: 'Tell your friends about Daleeli',
              onTap: () {},
            ),

            ProfileMenuCard(
              icon: Icons.info_outline,
              title: 'About',
              subtitle: 'App version & info',
              onTap: () {},
            ),

            const SizedBox(height: 12),
            CustomElevatedButton(text: "Log out", onTap: () {}),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
