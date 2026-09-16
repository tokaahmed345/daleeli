import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:daleeli/core/utils/styles/app_style.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hint;
  final String? label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? icon;
  final IconData? suffixIcon;
  final void Function()? onPressed;
  final bool obscure;
  final bool? enabled;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final double? radius;

  const CustomFormField({
    super.key,
    required this.hint,
    required this.controller,
    this.label,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.icon,
    this.suffixIcon,
    this.obscure = false,
    this.onPressed,
    this.enabled,
    this.fillColor,
    this.borderColor,
    this.hintStyle,
    this.contentPadding,
    this.radius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor =
        borderColor ?? AppColors.primary.withOpacity(.8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!.toUpperCase(),
            style: AppStyle.text12.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
        ],

        TextFormField(
          enabled: enabled,
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          validator: validator,
          cursorColor: AppColors.primary,
          style: AppStyle.text14.copyWith(color: AppColors.charcoal),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                hintStyle ??
                AppStyle.text14.copyWith(
                  color: AppColors.secondary.withOpacity(0.5),
                ),
            prefixIcon: icon != null
                ? Icon(icon, color: AppColors.secondary, size: 20)
                : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(
                      suffixIcon,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                    onPressed: onPressed,
                  )
                : null,
            filled: true,
            fillColor: fillColor ?? AppColors.warmBeige.withOpacity(.6),
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(color: effectiveBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(color: effectiveBorderColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: BorderSide(color: effectiveBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: const BorderSide(color: AppColors.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius!),
              borderSide: const BorderSide(
                color: AppColors.redColor,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
