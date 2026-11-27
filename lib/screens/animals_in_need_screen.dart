import 'package:flutter/material.dart';
import '../data/dummy_animals.dart';
import '../data/mock_data.dart';
import '../widgets/animal_card.dart';
import '../widgets/app_chip.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/coming_soon.dart';
import '../widgets/round_icon_button.dart';
import '../models/animal.dart';
import 'adopter_profile_screen.dart';
import 'owner_profile_screen.dart';
import 'shelter_profile_screen.dart';


class AnimalsInNeedScreen extends StatefulWidget {
  const AnimalsInNeedScreen({super.key});

  @override
  State<AnimalsInNeedScreen> createState() => _AnimalsInNeedScreenState();
}

class _AnimalsInNeedScreenState extends State<AnimalsInNeedScreen> {
  static const _chips = ['All', 'Dogs', 'Cats', 'Injured'];
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
    if (i == 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
      return;
    }
    if (i == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => _profileForRole()),
      );
      return;
    }
    comingSoon(context, const ['Home', 'Search', 'Saved', 'Requests', 'Profile'][i]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final animals = urgentAnimals.where((a) => a.matchesChip(_chip)).toList();

    return Scaffold(
      bottomNavigationBar: PetNetBottomNavBar(
        currentIndex: -1,
        showPost: true,
        onTap: _onTab,
        // TODO(B): Post an animal (page 20)
        onPost: () => comingSoon(context, 'Post an animal'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  RoundIconButton(
                    icon: Icons.chevron_left,
                    onTap: () => Navigator.maybePop(context),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('Animals in need of help',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge),
                        const SizedBox(height: 2),
                        Text('${animals.length} animals are waiting for you',
                            style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final c in _chips) ...[
                            AppChip(
                              label: c,
                              selected: _chip == c,
                              onTap: () => setState(() => _chip = c),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ],
                      ),
                    ),
                  ),
                  RoundIconButton(
                    icon: Icons.tune,
                    // TODO(day4): Filters (page 8)
                    onTap: () => comingSoon(context, 'Filters'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: animals.isEmpty
                  ? Center(
                      child: Text('No animals in this category.',
                          style: theme.textTheme.bodySmall),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                      itemCount: animals.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (_, i) => AnimalCard(
                        animal: animals[i],
                        variant: AnimalCardVariant.large,
                        // TODO(day5): Animal details (page 9)
                        onTap: () => comingSoon(context, 'Animal details'),
                        // TODO(day6): Send a request (page 12)
                        onHelp: () => comingSoon(context, 'Send a request'),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}