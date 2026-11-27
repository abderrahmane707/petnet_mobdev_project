import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/petnet_logo.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 110,
                right: 60,
                child: Icon(Icons.auto_awesome,
                    size: 28, color: AppColors.green.withValues(alpha: 0.7)),
              ),
              Positioned(
                left: 50,
                bottom: 230,
                child: Icon(Icons.pets,
                    size: 18, color: AppColors.green.withValues(alpha: 0.6)),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 130,
                      errorBuilder: (_, __, ___) => const Icon(Icons.pets,
                          size: 90, color: AppColors.primary),
                    ),
                    const SizedBox(height: 16),
                    const PetNetLogo(size: 44, showIcon: false),
                    const SizedBox(height: 24),
                    Text(
                      'One Network,\nCountless Second Chances',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 28,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.pets, size: 16, color: AppColors.brown),
                    const SizedBox(width: 8),
                    Text('Tap anywhere to continue',
                        style: theme.textTheme.labelMedium),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}