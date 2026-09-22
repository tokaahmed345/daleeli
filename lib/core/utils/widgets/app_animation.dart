import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

abstract class AppAnimation {
  static Widget detailEntrance({required Widget child, int delay = 0}) {
    return child
        .animate(delay: delay.ms)
        .fadeIn(duration: 350.ms, curve: Curves.easeOut)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 400.ms,
          curve: Curves.easeOutBack,
        );
  }
}
