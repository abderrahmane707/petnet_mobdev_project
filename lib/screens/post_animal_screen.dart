import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/app_chip.dart';
import '../widgets/coming_soon.dart';
import '../widgets/round_icon_button.dart';

class PostAnimalScreen extends StatefulWidget {
  const PostAnimalScreen({super.key});

  @override
  State<PostAnimalScreen> createState() =>
      _PostAnimalScreenState();
}

class _PostAnimalScreenState extends State<PostAnimalScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final notesController = TextEditingController();

  String selectedSpecies = 'Cat';
  String selectedSex = 'Male';
  String selectedSize = 'Small';
  String selectedVaccination = 'Vaccinated';

  static const _bg = Color(0xFFF7EBDD);
  static const _brown = Color(0xFF4B2A1B);

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    notesController.dispose();

    super.dispose();
  }

  Widget _label(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: theme.textTheme.titleSmall),
    );
  }

  Widget _chipGroup(
    List<String> options,
    String selected,
    ValueChanged<String> onSelect,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((o) {
        return AppChip(
          label: o,
          selected: selected == o,
          onTap: () {
            setState(() {
              onSelect(o);
            });
          },
        );
      }).toList(),
    );
  }

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
        automaticallyImplyLeading: false,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: RoundIconButton(
            icon: Icons.chevron_left,
            onTap: () => Navigator.maybePop(context),
          ),
        ),
        title: Text(
          'Post an animal',
          style: theme.textTheme.titleLarge?.copyWith(color: _brown),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => comingSoon(context, 'Save draft'),
            child: const Text('Save draft'),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Help the right family get to know them.',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.pets,
                          size: 12, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        '2 of 3 used',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 110,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _photoBox(context, main: true),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(child: _photoBox(context)),
                        const SizedBox(height: 10),
                        Expanded(child: _photoBox(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            CustomTextField(
              label: "Animal's name",
              hint: 'e.g. Rami',
              controller: nameController,
            ),

            const SizedBox(height: 14),

            _label(theme, 'Species'),
            _chipGroup(
              ['Cat', 'Dog', 'Other'],
              selectedSpecies,
              (v) => selectedSpecies = v,
            ),

            const SizedBox(height: 14),

            CustomTextField(
              label: 'Age',
              hint: 'Example: 2 years',
              controller: ageController,
            ),

            const SizedBox(height: 14),

            _label(theme, 'Sex'),
            _chipGroup(
              ['Male', 'Female', 'Unknown'],
              selectedSex,
              (v) => selectedSex = v,
            ),

            const SizedBox(height: 14),

            _label(theme, 'Size'),
            _chipGroup(
              ['Small', 'Medium', 'Large'],
              selectedSize,
              (v) => selectedSize = v,
            ),

            const SizedBox(height: 14),

            _label(theme, 'Vaccination'),
            _chipGroup(
              ['Vaccinated', 'Not vaccinated', 'Unknown'],
              selectedVaccination,
              (v) => selectedVaccination = v,
            ),

            const SizedBox(height: 14),

            _label(theme, 'Additional information'),

            TextField(
              controller: notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Describe the animal and its personality...',
                hintStyle: theme.textTheme.bodyMedium
                    ?.copyWith(color: AppColors.textHint),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),

            const SizedBox(height: 26),

            CustomButton(
              label: 'Post animal',
              onPressed: () {
                if (nameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter the animal name'),
                    ),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Animal posted (demo only)'),
                  ),
                );

                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 12),

            CustomButton(
              label: 'Cancel',
              kind: ButtonKind.secondary,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoBox(
    BuildContext context, {
    bool main = false,
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => comingSoon(context, 'Upload photo'),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: main ? AppColors.surface : const Color(0xFFEBDCC8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              main ? Icons.camera_alt_outlined : Icons.add,
              size: main ? 26 : 20,
              color: AppColors.primary,
            ),
            if (main) ...[
              const SizedBox(height: 6),
              Text(
                'Add photos',
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: AppColors.primary),
              ),
              Text('Up to 4', style: theme.textTheme.labelSmall),
            ],
          ],
        ),
      ),
    );
  }
}