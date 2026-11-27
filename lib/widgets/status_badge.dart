import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

enum BadgeKind { available, pending, urgent, adopted, condition }

class StatusBadge extends StatelessWidget {
  final BadgeKind kind;
  final String? label;

  const StatusBadge(this.kind, {super.key, this.label});

  String get _text =>
      label ??
      switch (kind) {
        BadgeKind.available => 'Available',
        BadgeKind.pending => 'Pending',
        BadgeKind.urgent => 'Urgent',
        BadgeKind.adopted => 'Adopted',
        BadgeKind.condition => '',
      };

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg, Color border) = switch (kind) {
      BadgeKind.available => (
          AppColors.greenSoft,
          AppColors.green,
          AppColors.greenBorder
        ),
      BadgeKind.pending => (
          AppColors.pendingSoft,
          AppColors.pending,
          AppColors.pendingBorder
        ),
      BadgeKind.urgent => (AppColors.urgent, AppColors.white, AppColors.urgent),
      BadgeKind.adopted => (
          AppColors.adoptedSoft,
          AppColors.adopted,
          AppColors.adoptedBorder
        ),
      BadgeKind.condition => (
          AppColors.urgentSoft,
          AppColors.urgent,
          AppColors.urgentSoft
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (kind == BadgeKind.available) ...[
            Icon(Icons.check, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            _text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: fg,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}