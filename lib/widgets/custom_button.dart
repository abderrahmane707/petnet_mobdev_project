import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

enum ButtonKind { primary, secondary, destructive }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonKind kind;
  final IconData? icon;
  final double height;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.kind = ButtonKind.primary,
    this.icon,
    this.height = 54,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );

    if (kind == ButtonKind.secondary) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: OutlinedButton(onPressed: onPressed, child: child),
      );
    }

    final bg =
        kind == ButtonKind.destructive ? AppColors.urgent : AppColors.primary;

    // Soft coloured edge under the button, like in the design.
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: bg.withValues(alpha: 0.35),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: bg),
          child: child,
        ),
      ),
    );
  }
}