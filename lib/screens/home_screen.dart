import 'package:flutter/material.dart';

import '../data/dummy_animals.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../models/animal.dart';
import '../widgets/animal_card.dart';
import '../widgets/app_chip.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/coming_soon.dart';
import '../widgets/petnet_logo.dart';
import '../widgets/round_icon_button.dart';
import 'animals_in_need_screen.dart';
import 'adopter_profile_screen.dart';
import 'owner_profile_screen.dart';
import 'shelter_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _userName = 'Amina';
  static const _chips = ['All', 'Dogs', 'Cats', 'Birds', 'Other'];
  static const _hp = EdgeInsets.symmetric(horizontal: 20);

  String _chip = 'All';

  Widget _profileForRole() {
    switch (selectedUserRole.toLowerCase()) {
      case 'owner':
        return const OwnerProfileScreen();
      case 'shelter':
        return const ShelterProfileScreen();
      default:
        return const AdopterProfileScreen();
    }
  }

  void _onTab(int i) {
    if (i == 0) return; // Already on Home

    if (i == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => _profileForRole()),
      );
      return;
    }

    comingSoon(
      context,
      const ['Home', 'Search', 'Saved', 'Requests', 'Profile'][i],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final urgent = urgentAnimals.where((a) => a.matchesChip(_chip)).toList();
    final nearby = nearbyAnimals.where((a) => a.matchesChip(_chip)).toList();

    return Scaffold(
      bottomNavigationBar: PetNetBottomNavBar(currentIndex: 0, onTap: _onTab),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          children: [
            // Header
            Padding(
              padding: _hp,
              child: Row(
                children: [
                  const PetNetLogo(size: 20),
                  const Spacer(),
                  RoundIconButton(
                    icon: Icons.chat_bubble_outline,
                    // TODO(day6): Messages screen (page 13)
                    onTap: () => comingSoon(context, 'Messages'),
                  ),
                  const SizedBox(width: 8),
                  RoundIconButton(
                    icon: Icons.notifications_none,
                    // TODO(day6): Notifications screen (page 15)
                    onTap: () => comingSoon(context, 'Notifications'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Greeting + location
            Padding(
              padding: _hp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good morning, $_userName',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.brown,
                        ),
                        const SizedBox(width: 4),
                        Text('Oran', style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Search bar
            Padding(
              padding: _hp,
              child: GestureDetector(
                // TODO(day4): open Search screen (page 7)
                onTap: () => comingSoon(context, 'Search'),
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        size: 20,
                        color: AppColors.brown,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Search animals, shelters, vets',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textHint,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.filter_alt_outlined,
                        size: 20,
                        color: AppColors.brown,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Species chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: _hp,
                itemCount: _chips.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => AppChip(
                  label: _chips[i],
                  selected: _chip == _chips[i],
                  onTap: () => setState(() => _chip = _chips[i]),
                ),
              ),
            ),
            const SizedBox(height: 22),

            // Animals in need of help
            Padding(
              padding: _hp,
              child: _SectionHeader(
                title: 'Animals in need of help',
                leadingIcon: Icons.favorite,
                onSeeAll: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AnimalsInNeedScreen(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (urgent.isEmpty)
              const Padding(
                padding: _hp,
                child: _EmptyNote('No urgent animals in this category.'),
              )
            else
              SizedBox(
                height: 256,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: _hp,
                  itemCount: urgent.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => AnimalCard(
                    animal: urgent[i],
                    variant: AnimalCardVariant.urgent,
                    // TODO(day5): Animal details (page 9)
                    onTap: () => comingSoon(context, 'Animal details'),
                  ),
                ),
              ),
            const SizedBox(height: 18),
            const Padding(padding: _hp, child: Divider()),
            const SizedBox(height: 18),

            // Near you
            Padding(
              padding: _hp,
              child: _SectionHeader(
                title: 'Near you',
                // TODO(day4): Search results (page 7)
                onSeeAll: () => comingSoon(context, 'Search'),
              ),
            ),
            const SizedBox(height: 12),
            if (nearby.isEmpty)
              const Padding(
                padding: _hp,
                child: _EmptyNote('No animals near you in this category.'),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: _hp,
                itemCount: nearby.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 236,
                ),
                itemBuilder: (_, i) => AnimalCard(
                  animal: nearby[i],
                  // TODO(day5): Animal details (page 9)
                  onTap: () => comingSoon(context, 'Animal details'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback onSeeAll;

  const _SectionHeader({
    required this.title,
    required this.onSeeAll,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: 18, color: AppColors.urgent),
          const SizedBox(width: 8),
        ],
        Expanded(child: Text(title, style: theme.textTheme.titleLarge)),
        TextButton(
          onPressed: onSeeAll,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('See all'),
        ),
      ],
    );
  }
}

class _EmptyNote extends StatelessWidget {
  final String text;
  const _EmptyNote(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodySmall);
  }
}
