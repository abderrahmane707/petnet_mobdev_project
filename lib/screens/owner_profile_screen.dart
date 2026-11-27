import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/coming_soon.dart';
import '../widgets/round_icon_button.dart';
import '../widgets/status_badge.dart';

import 'post_animal_screen.dart';
import 'edit_profile_screen.dart';

class OwnerProfileScreen extends StatelessWidget {
  const OwnerProfileScreen({super.key});

  static const _bg = Color(0xFFF7EBDD);
  static const _brown = Color(0xFF4B2A1B);
  static const _segmentBg = Color(0xFFEBDCC8);

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
                    decoration: BoxDecoration(
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
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFE9D4BD),
                      backgroundImage:
                          AssetImage('assets/images/profile.png'),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Rami',
                    style: theme.textTheme.headlineSmall,
                  ),

                  const SizedBox(height: 6),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                      color: _segmentBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Animal owner',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: _brown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 14, color: AppColors.brown),
                      const SizedBox(width: 3),
                      Text('Algiers', style: theme.textTheme.bodySmall),
                    ],
                  ),

                  const SizedBox(height: 14),

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

            const SizedBox(height: 18),

            // My animals card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.pets,
                            size: 20, color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('My animals',
                                style: theme.textTheme.titleMedium),
                            Text('Animals posted',
                                style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                      Text(
                        '2 / 3',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  LinearProgressIndicator(
                    value: 2 / 3,
                    minHeight: 6,
                    color: AppColors.primary,
                    backgroundColor: _segmentBg,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'You can post 1 more animal',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            _animalRow(
              context,
              name: 'Felfel',
              details: 'Cat • 2 years old',
              badge: BadgeKind.available,
            ),

            const SizedBox(height: 10),

            _animalRow(
              context,
              name: 'Nougat',
              details: 'Dog • 1 year old',
              badge: BadgeKind.pending,
            ),

            const SizedBox(height: 10),

            _animalRow(
              context,
              name: 'Louna',
              details: 'Cat • 3 years old',
              badge: BadgeKind.adopted,
            ),

            const SizedBox(height: 22),

            CustomButton(
              label: 'Post an animal',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PostAnimalScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            CustomButton(
              label: 'Edit my profile',
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

      bottomNavigationBar: PetNetBottomNavBar(
        currentIndex: 4,
        showPost: true,
        onTap: (index) {
          if (index != 4) {
            comingSoon(context, 'Navigation');
          }
        },
        onPost: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PostAnimalScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _animalRow(
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

          GestureDetector(
            onTap: () => comingSoon(context, 'Animal options'),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.edit_outlined,
                  size: 18, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}