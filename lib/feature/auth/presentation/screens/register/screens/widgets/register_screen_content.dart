import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/feature/auth/presentation/screens/register/screens/widgets/register_form.dart';
import 'package:flutter/material.dart';

class RegisterScreenContent extends StatelessWidget {
  const RegisterScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: size.height * 0.35,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_add_outlined,
                  size: 70,
                  color: AppColors.whiteColor,
                ),
                const SizedBox(height: 10),
                Text('Create Account', style: AppStyle.text24),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.28),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const RegisterForm(),
            ),
          ),
        ),
      ],
    );
  }
}