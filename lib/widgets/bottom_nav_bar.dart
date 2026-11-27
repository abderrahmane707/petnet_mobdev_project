import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Tabs: 0 Home, 1 Search, 2 Saved, 3 Requests, 4 Profile.
/// When [showPost] is true the middle slot becomes the round Post button
/// (owner / shelter version of the bar). Use currentIndex = -1 for no highlight.
class PetNetBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showPost;
  final VoidCallback? onPost;

  const PetNetBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showPost = false,
    this.onPost,
  });

  static const _items = <(IconData, IconData, String)>[
    (Icons.home_outlined, Icons.home_rounded, 'Home'),
    (Icons.search, Icons.search, 'Search'),
    (Icons.favorite_border, Icons.favorite, 'Saved'),
    (Icons.assignment_outlined, Icons.assignment, 'Requests'),
    (Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    const barHeight = 68.0;
    const bottomGap = 12.0;
    final extra = showPost ? 26.0 : 0.0;
    final labelStyle = Theme.of(context)
        .textTheme
        .labelSmall
        ?.copyWith(fontSize: 10.5, fontWeight: FontWeight.w800);

    return SafeArea(
      top: false,
      child: SizedBox(
        height: barHeight + bottomGap + extra,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 16,
              right: 16,
              bottom: bottomGap,
              height: barHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.brown,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Row(
                  children: [
                    for (var i = 0; i < _items.length; i++)
                      Expanded(
                        child: (showPost && i == 2)
                            ? GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: onPost,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 22),
                                    const SizedBox(height: 3),
                                    Text('Post',
                                        style: labelStyle?.copyWith(
                                            color: AppColors.textOnDark)),
                                  ],
                                ),
                              )
                            : _NavItem(
                                icon: i == currentIndex
                                    ? _items[i].$2
                                    : _items[i].$1,
                                label: _items[i].$3,
                                selected: i == currentIndex,
                                style: labelStyle,
                                onTap: () => onTap(i),
                              ),
                      ),
                  ],
                ),
              ),
            ),
            if (showPost)
              Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: onPost,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.background, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.brown.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add, color: AppColors.white, size: 30),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final TextStyle? style;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.style,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.surfaceDim;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 3),
          Text(label, style: style?.copyWith(color: color)),
        ],
      ),
    );
  }
}