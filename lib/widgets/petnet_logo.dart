import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PetNetLogo extends StatelessWidget {
  final double size;
  final bool showIcon;

  const PetNetLogo({super.key, this.size = 24, this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(fontSize: size, fontWeight: FontWeight.w800);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          Image.asset(
            'assets/images/logo.png',
            height: size * 1.4,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
          const SizedBox(width: 6),
        ],
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Pet', style: base.copyWith(color: AppColors.brown)),
              TextSpan(text: 'Net', style: base.copyWith(color: AppColors.primary)),
            ],
          ),
        ),
      ],
    );
  }
}