import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/app_chip.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/coming_soon.dart';
import '../widgets/round_icon_button.dart';
import '../widgets/status_badge.dart';

import 'owner_profile_screen.dart';
import 'shelter_profile_screen.dart';
import 'edit_profile_screen.dart';

class AdopterProfileScreen extends StatefulWidget {
  const AdopterProfileScreen({super.key});

  @override
  State<AdopterProfileScreen> createState() => _AdopterProfileScreenState();
}

class _AdopterProfileScreenState extends State<AdopterProfileScreen> {
  int selectedTab = 0;

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
          children: [
            // Avatar
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
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),

            const SizedBox(height: 12),

            Text('Mina', style: theme.textTheme.headlineSmall),

            const SizedBox(height: 6),

            // Role pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              decoration: BoxDecoration(
                color: _segmentBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Animal lover',
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
                const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: AppColors.brown,
                ),
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
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              },
            ),

            const SizedBox(height: 18),

            // Segmented tabs
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _segmentBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(child: _segment(theme, 'Saved animals', 0)),
                  Expanded(child: _segment(theme, 'My requests', 1)),
                ],
              ),
            ),

            const SizedBox(height: 18),

            if (selectedTab == 0) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _animalCard(context, 'Felfel', 'Cat • 2 years old'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _animalCard(context, 'Nougat', 'Dog • 1 year old'),
                  ),
                ],
              ),
            ] else ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent requests',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 10),
              _requestCard(context),
            ],

            const SizedBox(height: 25),

            const Divider(),

            const SizedBox(height: 10),

            Text('Other profiles (demo)', style: theme.textTheme.titleSmall),

            const SizedBox(height: 12),

            CustomButton(
              label: 'Owner profile',
              kind: ButtonKind.secondary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OwnerProfileScreen()),
                );
              },
            ),

            const SizedBox(height: 10),

            CustomButton(
              label: 'Shelter profile',
              kind: ButtonKind.secondary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ShelterProfileScreen(),
                  ),
                );
              },
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

  Widget _segment(ThemeData theme, String label, int index) {
    final selected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() => selectedTab = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: selected ? AppColors.primary : _brown,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _animalCard(BuildContext context, String name, String details) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    name == 'Felfel'
                        ? 'assets/images/felfel.png'
                        : 'assets/images/nougat.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      child: const Icon(Icons.pets, size: 32),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () => comingSoon(context, 'Remove saved animal'),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(details, style: theme.textTheme.bodySmall),
                const SizedBox(height: 6),
                const StatusBadge(BadgeKind.available),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _requestCard(BuildContext context) {
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
            child: Image.asset(
              'assets/images/felfel.png',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 48,
                height: 48,
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                child: const Icon(Icons.pets, size: 24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adoption request - Felfel',
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 2),
                Text('Refuge El Rifq', style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          const StatusBadge(BadgeKind.pending),
        ],
      ),
    );
  }
}
