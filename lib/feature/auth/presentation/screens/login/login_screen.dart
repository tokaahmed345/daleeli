import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/helper/app_system_ui.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:daleeli/feature/auth/presentation/screens/login/widgets/login_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text('Welcome Back', style: AppStyle.text20),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),

        child: LoginScreenContent(),
      ),
    );
  }
}
