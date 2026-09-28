import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onTap,
    this.isLoading = false,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.foreground,
    this.background,
    this.borderColor,
    this.borderWidth, 
  });

  final String text;
  final VoidCallback? onTap;
  final bool isLoading;
  final double? width;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? foreground;
  final Color? background;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final Color buttonBackground = background ?? AppColors.primary;

    final Color buttonForeground = foreground ?? AppColors.approveLightBg;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBackground,
          disabledBackgroundColor: isLoading
              ? buttonBackground
              : AppColors.darkSurface,
          foregroundColor: buttonForeground,
          disabledForegroundColor: buttonForeground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth ?? 1.5.w)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: buttonForeground))
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[prefixIcon!, SizedBox(width: 8)],
                  Text(text, style: AppStyle.text16),
                  if (suffixIcon != null) ...[SizedBox(width: 8), suffixIcon!],
                ],
              ),
      ),
    );
  }
}
