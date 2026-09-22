import 'package:daleeli/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
     this.message,
    required this.buttonText,
    required this.onButtonPressed,
    this.isError = false,
  });

  final String title;
  final String? message;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: isError ? AppColors.redColor : AppColors.greenColor,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title)),
        ],
      ),
      content: Text(message??""),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isError ? AppColors.redColor : AppColors.greenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onButtonPressed,
          child: Text(buttonText, style: const TextStyle(color: AppColors.whiteColor)),
        ),
      ],
    );
  }
}