import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/dependency_injection/service_locator.dart';
import 'package:daleeli/core/utils/router/routes_name.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        "Log out",
        style: AppStyle.text18.copyWith(color: AppColors.whiteColor),
      ),
      content: Text(
        "Are you sure you want to log out?",
        style: AppStyle.text14.copyWith(color: AppColors.grey700),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Cancel",
            style: AppStyle.text14.copyWith(color: AppColors.approveLightBg),
          ),
        ),
        TextButton(
          onPressed: () {
            getIt.get<FirebaseAuth>().signOut();
                       Navigator.pushNamed(context, RoutesName.login);
 
          },
          child: Text(
            'Log out',
            style: AppStyle.text14.copyWith(
              color: AppColors.redColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
