import 'package:flutter/material.dart';
import '../data/wilayas.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/round_icon_button.dart';
import 'home_screen.dart';

class _Role {
  final String title;
  final String description;
  final String tagline;
  final IconData icon;
  const _Role(this.title, this.description, this.tagline, this.icon);
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _wilayaCtrl = TextEditingController();
  int _role = 0;

  static const _roles = [
    _Role('Adopter', 'I want to adopt or foster an animal.',
        'Browse, request, save.', Icons.favorite_border),
    _Role('Owner', 'I must rehome my pet.', 'Up to 5 animals, free.',
        Icons.pets),
    _Role('Shelter / Rescuer', 'I run a shelter or rescue.',
        '2 free animals, subscribe for 3 or more.', Icons.home_work_outlined),
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _wilayaCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickWilaya() async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(ctx).size.height * 0.65,
        child: Column(
          children: [
            Text('Select your wilaya',
                style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: kWilayas.length,
                itemBuilder: (_, i) {
                  final name = kWilayas[i];
                  final selected = name == _wilayaCtrl.text;
                  return ListTile(
                    title: Text(name, style: Theme.of(ctx).textTheme.bodyLarge),
                    trailing: selected
                        ? const Icon(Icons.check, color: AppColors.green)
                        : null,
                    onTap: () => Navigator.pop(ctx, name),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    if (picked != null) setState(() => _wilayaCtrl.text = picked);
  }

  void _createAccount() {
    // MVP: no backend, go straight to home.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RoundIconButton(
                    icon: Icons.chevron_left,
                    onTap: () => Navigator.maybePop(context),
                  ),
                  Expanded(
                    child: Text('Create account',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
              const SizedBox(height: 16),
              Text("Join Algeria's caring animal community.",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Full name',
                hint: 'Your name',
                controller: _nameCtrl,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                hint: 'hello@example.com',
                prefixIcon: Icons.mail_outline,
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                hint: 'At least 8 characters',
                prefixIcon: Icons.lock_outline,
                controller: _passwordCtrl,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Wilaya',
                hint: 'Select your wilaya',
                controller: _wilayaCtrl,
                readOnly: true,
                onTap: _pickWilaya,
                suffix: const Icon(Icons.chevron_right),
              ),
              const SizedBox(height: 20),
              Text('I am joining as', style: theme.textTheme.titleSmall),
              const SizedBox(height: 10),
              for (var i = 0; i < _roles.length; i++) ...[
                _RoleCard(
                  role: _roles[i],
                  selected: _role == i,
                  onTap: () => setState(() => _role = i),
                ),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 8),
              CustomButton(label: 'Create account', onPressed: _createAccount),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                      style: theme.textTheme.bodyMedium),
                  TextButton(
                    onPressed: () => Navigator.maybePop(context),
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final _Role role;
  final bool selected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.role,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(role.icon, color: AppColors.primary, size: 32),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(role.title,
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 18)),
                  const SizedBox(height: 2),
                  Text(role.description, style: theme.textTheme.bodySmall),
                  const SizedBox(height: 2),
                  Text(
                    role.tagline,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: AppColors.adopted),
                  ),
                ],
              ),
            ),
            if (selected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}