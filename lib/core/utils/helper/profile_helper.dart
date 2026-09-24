import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/feature/profile/presentation/screens/widgets/log_out_dialoge.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileHelper {
  
  static Future<void> onHelpTap(BuildContext context) async {
    final emailUri = Uri(
      scheme: 'mailto',
      path: "support@daleeli.app",
      query: 'subject: Daleeli Support',
    );

    try {
      final launched = await launchUrl(emailUri);
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No email app found on this device')),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open email app: $e')),
      );
    }
  }

  static Future<void> onShareTap(BuildContext context) async {
    try {
      await Share.share( 'Check out Daleeli and discover amazing trip plans in Egypt 🇪🇬');
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open share sheet: $e')),
      );
    }
  }

  // 3. About Bottom Sheet Logic
  static Future<void> onAboutTap(BuildContext context) async {
    String version = '';
    try {
      final info = await PackageInfo.fromPlatform();
      version = 'Version ${info.version}';
    } catch (_) {
      version = '';
    }

    if (!context.mounted) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.accentGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.explore_outlined,
                size: 32,
                color: AppColors.accentGold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Daleeli",
              style: AppStyle.text20.copyWith(
                color: AppColors.charcoal,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (version.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                version,
                style: AppStyle.text12.copyWith(color: AppColors.grey700),
              ),
            ],
            const SizedBox(height: 16),
            Text(
'Your honest travel companion to discover the best trip plans in Egypt.',
              textAlign: TextAlign.center,
              style: AppStyle.text14.copyWith(
                color: AppColors.grey700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => LogoutDialog(
        onConfirm: () {
          getIt.get<FirebaseAuth>().signOut();
        },
      ),
    );
  }
}