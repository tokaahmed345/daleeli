import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final int maxLines;
  final double borderRadius;
  final Color? fillColor;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final Color? textColor;

  const CustomInputField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.maxLines = 1,
    this.borderRadius = 16,
    this.fillColor,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppStyle.text14.copyWith(
        color: textColor ?? AppColors.blackColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.text14.copyWith(
          color: AppColors.greyColor,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.greyColor)
            : null,
        filled: true,
        fillColor: fillColor ?? AppColors.whiteColor.withOpacity(0.7),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}