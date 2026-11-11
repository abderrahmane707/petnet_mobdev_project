import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds & surfaces
  static const Color background = Color(0xFFF6EBDD); // app background (cream)
  static const Color surface = Color(0xFFFFF8EE); // cards, inputs
  static const Color surfaceDim = Color(0xFFE8D5BC); // tab tracks, dividers
  static const Color border = Color(0xFFE8D5BC);

  // Brand
  static const Color primary = Color(0xFFE07B39); // orange
  static const Color primaryPressed = Color(0xFFC9672A); // estimate
  static const Color primarySoft = Color(0xFFF4DCCA); // pale orange, button shadow
  static const Color brown = Color(0xFF4A2C1D); // nav bar, dark cards, headings

  // Text
  static const Color textPrimary = brown;
  static const Color textSecondary = Color(0xFF8A6A55); // estimate
  static const Color textHint = Color(0xFFB39A86); // estimate
  static const Color textOnDark = Color(0xFFFFF8EE);

  // Status: available / success
  static const Color green = Color(0xFF7C9A5E);
  static const Color greenSoft = Color(0xFFEBEAD9);
  static const Color greenBorder = Color(0xFFCBD3B7);
  static const Color trustBox = Color(0xFFE7E1CD); // "Your trust matters" box

  // Status: urgent / destructive
  static const Color urgent = Color(0xFFB5412F);
  static const Color urgentSoft = Color(0xFFF8DFD8); // estimate, "Injured" badge

  // Status: pending
  static const Color pending = Color(0xFF9A7420); // estimate
  static const Color pendingSoft = Color(0xFFF9EBD5);
  static const Color pendingBorder = Color(0xFFE5CF9B); // estimate

  // Status: adopted / new
  static const Color adopted = Color(0xFFC9672A); // estimate
  static const Color adoptedSoft = Color(0xFFFAE5D3);
  static const Color adoptedBorder = Color(0xFFF0C9A8); // estimate

  static const Color white = Colors.white;
}