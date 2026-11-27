import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'status_badge.dart';

/// urgent  = horizontal carousel card on Home
/// compact = "Near you" grid card
/// large   = full-width card on "Animals in need of help"
enum AnimalCardVariant { urgent, compact, large }

class AnimalCard extends StatefulWidget {
  final Animal animal;
  final AnimalCardVariant variant;
  final VoidCallback? onTap;
  final VoidCallback? onHelp; // large variant only ("Help now")

  const AnimalCard({
    super.key,
    required this.animal,
    this.variant = AnimalCardVariant.compact,
    this.onTap,
    this.onHelp,
  });

  @override
  State<AnimalCard> createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  bool _fav = false;

  Animal get a => widget.animal;

  BadgeKind get _statusKind {
    if (a.isUrgent) return BadgeKind.urgent;
    switch (a.status) {
      case AnimalStatus.pending:
        return BadgeKind.pending;
      case AnimalStatus.adopted:
        return BadgeKind.adopted;
      case AnimalStatus.available:
        return BadgeKind.available;
    }
  }

  Widget _heart() => GestureDetector(
        onTap: () => setState(() => _fav = !_fav),
        child: Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
          ),
          child: Icon(
            _fav ? Icons.favorite : Icons.favorite_border,
            size: 18,
            color: AppColors.primary,
          ),
        ),
      );

  Widget _photo(double height) {
    final v = widget.variant;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              a.image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.surfaceDim,
                child: const Icon(Icons.pets, size: 40, color: AppColors.brown),
              ),
            ),
            if (a.isUrgent && v != AnimalCardVariant.compact)
              const Positioned(
                top: 10,
                left: 10,
                child: StatusBadge(BadgeKind.urgent),
              ),
            if (v != AnimalCardVariant.urgent)
              Positioned(top: 8, right: 8, child: _heart()),
          ],
        ),
      ),
    );
  }

  Widget _urgentBody(TextTheme t) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _photo(150),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.name, style: t.titleLarge),
                const SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    style: t.bodySmall,
                    children: [
                      TextSpan(text: a.ageLabel),
                      if (a.condition != null) ...[
                        const TextSpan(text: ' · '),
                        TextSpan(
                          text: a.condition,
                          style: t.bodySmall?.copyWith(
                            color: AppColors.urgent,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(a.shelterName, style: t.bodySmall),
              ],
            ),
          ),
        ],
      );

  Widget _compactBody(TextTheme t) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _photo(130),
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 8, 6, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.name, style: t.titleLarge?.copyWith(fontSize: 18)),
                Text('${a.ageLabel} · ${a.distanceLabel}', style: t.bodySmall),
                const SizedBox(height: 6),
                StatusBadge(_statusKind),
              ],
            ),
          ),
        ],
      );

  Widget _largeBody(TextTheme t) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _photo(200),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(a.name, style: t.headlineSmall)),
                    if (a.condition != null)
                      StatusBadge(BadgeKind.condition, label: a.condition),
                  ],
                ),
                const SizedBox(height: 2),
                Text(a.ageLabel, style: t.bodySmall),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(a.shelterName,
                        style: t.labelMedium?.copyWith(fontSize: 12)),
                    const SizedBox(width: 8),
                    const StatusBadge(BadgeKind.available, label: 'Verified'),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Waiting ${a.waitingDays} days', style: t.bodySmall),
                    ElevatedButton(
                      onPressed: widget.onHelp,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 40),
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                      ),
                      child: Text(
                        'Help now',
                        style: t.labelMedium
                            ?.copyWith(color: AppColors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final body = switch (widget.variant) {
      AnimalCardVariant.urgent => _urgentBody(t),
      AnimalCardVariant.compact => _compactBody(t),
      AnimalCardVariant.large => _largeBody(t),
    };

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Container(
        width: widget.variant == AnimalCardVariant.urgent ? 230 : null,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
        ),
        child: body,
      ),
    );
  }
}