import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/coming_soon.dart';
import '../widgets/round_icon_button.dart';
import '../widgets/status_badge.dart';

import 'edit_profile_screen.dart';

class ShelterProfileScreen extends StatelessWidget {
  const ShelterProfileScreen({super.key});

  static const _bg = Color(0xFFF7EBDD);
  static const _brown = Color(0xFF4B2A1B);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: _brown,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'My profile',
          style: theme.textTheme.titleLarge?.copyWith(color: _brown),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: RoundIconButton(
              icon: Icons.settings_outlined,
              onTap: () => comingSoon(context, 'Settings'),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9D4BD),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.home,
                      size: 36,
                      color: AppColors.brown,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Refuge El Rifq',
                    style: theme.textTheme.headlineSmall,
                  ),

                  const SizedBox(height: 6),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.green.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Verified shelter',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppColors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 14, color: AppColors.brown),
                      const SizedBox(width: 3),
                      Text('Algiers, Algeria',
                          style: theme.textTheme.bodySmall),
                    ],
                  ),

                  const SizedBox(height: 14),

                  CustomButton(
                    label: 'Contact shelter',
                    onPressed: () => comingSoon(context, 'Messages'),
                  ),

                  const SizedBox(height: 10),

                  CustomButton(
                    label: 'Edit profile',
                    kind: ButtonKind.secondary,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Counters in a single card with dividers
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Expanded(child: _counter(context, '12', 'Animals')),
                  _divider(),
                  Expanded(child: _counter(context, '8', 'Adopted')),
                  _divider(),
                  Expanded(child: _counter(context, '4', 'Available')),
                ],
              ),
            ),

            const SizedBox(height: 18),

            Text(
              'About us',
              style: theme.textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Text(
              'Refuge El Rifq cares for animals in need and helps '
              'them find loving and responsible families.',
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 18),

            Text(
              'Our animals',
              style: theme.textTheme.titleLarge,
            ),

            const SizedBox(height: 12),

            _listing(
              context,
              name: 'Felfel',
              details: 'Cat • 2 years old',
              badge: BadgeKind.available,
            ),

            const SizedBox(height: 10),

            _listing(
              context,
              name: 'Nougat',
              details: 'Dog • 1 year old',
              badge: BadgeKind.urgent,
            ),

            const SizedBox(height: 10),

            _listing(
              context,
              name: 'Louna',
              details: 'Cat • 3 years old',
              badge: BadgeKind.pending,
            ),
          ],
        ),
      ),

      bottomNavigationBar: PetNetBottomNavBar(
        currentIndex: 4,
        onTap: (index) {
          if (index != 4) {
            comingSoon(context, 'Navigation');
          }
        },
      ),
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 34, color: AppColors.border);
  }

  Widget _counter(
    BuildContext context,
    String number,
    String label,
  ) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          number,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _listing(
    BuildContext context, {
    required String name,
    required String details,
    required BadgeKind badge,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Image.asset(
                name == 'Felfel'
                    ? 'assets/images/felfel.png'
                    : name == 'Nougat'
                        ? 'assets/images/nougat.png'
                        : 'assets/images/louna.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  child: const Icon(Icons.pets, size: 28),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleMedium),
                Text(details, style: theme.textTheme.bodySmall),
                const SizedBox(height: 6),
                StatusBadge(badge),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.chevron_right, color: AppColors.brown),
            onPressed: () => comingSoon(context, 'Animal details'),
          ),
        ],
      ),
    );
  }
}