import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Use this for any button whose screen does not exist yet.
void comingSoon(BuildContext context, [String? feature]) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content:
            Text(feature == null ? 'Coming soon' : '$feature - coming soon'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.brown,
        duration: const Duration(milliseconds: 1600),
      ),
    );
}