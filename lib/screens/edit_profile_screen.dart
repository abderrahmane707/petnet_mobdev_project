import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/coming_soon.dart';
import '../widgets/round_icon_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController(text: 'Rami');
  final emailController = TextEditingController(text: 'rami@email.com');
  final phoneController = TextEditingController(text: '0550000000');
  final locationController = TextEditingController(text: 'Algiers');
  final organisationController =
      TextEditingController(text: 'Refuge El Rifq');

  static const _bg = Color(0xFFF7EBDD);
  static const _brown = Color(0xFF4B2A1B);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    organisationController.dispose();

    super.dispose();
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated (demo only)'),
      ),
    );

    Navigator.pop(context);
  }

  Widget _sectionDivider(ThemeData theme, String title) {
    return Row(
      children: [
        Text(
          title,
          style: theme.textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(child: Divider(height: 1)),
      ],
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
          'Edit profile',
          style: theme.textTheme.titleLarge?.copyWith(color: _brown),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
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

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => comingSoon(context, 'Change photo'),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            CustomTextField(
              label: 'Full name',
              hint: 'Enter your name',
              controller: nameController,
            ),

            const SizedBox(height: 14),

            CustomTextField(
              label: 'Email',
              hint: 'Enter your email',
              prefixIcon: Icons.mail_outline,
              controller: emailController,
            ),

            const SizedBox(height: 14),

            CustomTextField(
              label: 'Phone number',
              hint: 'Enter your phone',
              prefixIcon: Icons.phone_outlined,
              controller: phoneController,
            ),

            const SizedBox(height: 14),

            CustomTextField(
              label: 'Location',
              hint: 'Enter your location',
              prefixIcon: Icons.location_on_outlined,
              controller: locationController,
            ),

            const SizedBox(height: 22),

            _sectionDivider(theme, 'Organisation details'),

            const SizedBox(height: 14),

            CustomTextField(
              label: 'Organisation name',
              hint: 'Enter organisation name',
              controller: organisationController,
            ),

            const SizedBox(height: 14),

            Text('Description', style: theme.textTheme.titleSmall),

            const SizedBox(height: 8),

            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tell us about your organisation',
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

            const SizedBox(height: 22),

            CustomButton(
              label: 'Save changes',
              onPressed: _save,
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
}