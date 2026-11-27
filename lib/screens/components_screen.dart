import 'package:flutter/material.dart';
import '../data/dummy_animals.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/animal_card.dart';
import '../widgets/app_chip.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/status_badge.dart';

class ComponentsScreen extends StatefulWidget {
  const ComponentsScreen({super.key});

  @override
  State<ComponentsScreen> createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  String _chip = 'All';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Center(
              child: Text('PetNet components',
                  style: theme.textTheme.headlineSmall),
            ),
            const SizedBox(height: 16),
            _Section(
              title: 'Buttons',
              child: Column(
                children: [
                  CustomButton(label: 'Primary action', onPressed: () {}),
                  const SizedBox(height: 12),
                  CustomButton(
                    label: 'Secondary action',
                    kind: ButtonKind.secondary,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    label: 'Destructive action',
                    kind: ButtonKind.destructive,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const _Section(
              title: 'Status badges',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  StatusBadge(BadgeKind.available),
                  StatusBadge(BadgeKind.pending),
                  StatusBadge(BadgeKind.urgent),
                  StatusBadge(BadgeKind.adopted),
                  StatusBadge(BadgeKind.condition, label: 'Injured'),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _Section(
              title: 'Inputs & chips',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextField(
                    label: 'Input label',
                    hint: 'Friendly placeholder...',
                    prefixIcon: Icons.pets,
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final c in const ['All', 'Dogs', 'Cats', 'Other'])
                        AppChip(
                          label: c,
                          selected: _chip == c,
                          onTap: () => setState(() => _chip = c),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _Section(
              title: 'Animal card',
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 170,
                  child: AnimalCard(animal: kAnimals.first),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}