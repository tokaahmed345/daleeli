import 'package:flutter/material.dart';

abstract class AppColors {
  // ===== Core neutrals =====
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color whiteColor70 = Colors.white70;

  // ===== Brand colors =====
  static const Color primary = Color(0xFF1b3a4b);
  static const Color primaryDark = Color(0xFF232C17);
  static const Color secondary = Color(0xFF6B7260);
  static const Color accentGold = Color(0xFFE0A438);
  static const Color warmBeige = Color(0xFFEFE8D6);

  // ===== Text / surfaces =====
  static const Color charcoal = Color(0xFF26301C);
  static const Color lightBackground = Color(0xFFF6F1E4);
  static const Color tipsBackground = Color(0xFFFf6f1e4);
  static const Color background = Color.fromARGB(255, 238, 223, 185);

  // ===== Status colors =====
  static const Color redColor = Colors.red;
  static const Color redAccent = Colors.redAccent;
  static const Color greenColor = Colors.green;
  static const Color greyColor = Colors.grey;
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);

  // ===== Approve / Reject actions =====
  static const Color approveColor = Color(0xFF2C3E21);
  static const Color rejectColor = Color(0xFFC8421A);
  static const Color approveLightBg = Color(0xFFE6EFE1);
  static const Color questionBg = Color(0xFFE2EAD8);
  static const Color questionLabelColor = Color(0xFF536149);

  // ===== Dark mode variants =====
  static const Color darkBackground = Color(0xFF1B2013);
  static const Color darkSurface = Color(0xFF262E1A);
}