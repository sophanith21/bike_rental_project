import 'package:bike_rental_project/ui/my_app.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SelectedTab extends StatelessWidget {
  final ScreenNavigation screenNavigation;
  final String label;
  final IconData iconData;
  final bool iconFill;
  final ScreenNavigation currentSelectedScreen;
  final ValueChanged<ScreenNavigation> onTap;
  const SelectedTab({
    super.key,
    required this.screenNavigation,
    required this.label,
    required this.iconData,
    required this.onTap,
    required this.currentSelectedScreen,
    this.iconFill = false,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentSelectedScreen == screenNavigation;
    return GestureDetector(
      onTap: () => onTap(screenNavigation),
      child: AnimatedScale(
        scale: isSelected ? 1.005 : 0.9,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(color: AppTheme.accent, width: 2)
                : null,
            color: isSelected ? AppTheme.bgColor : Colors.transparent,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  fill: iconFill ? 1 : 0,
                  color: AppTheme.primary,
                  size: isSelected ? 50 : 40,
                ),
                Text(
                  label,
                  style: isSelected
                      ? AppTheme.titleMedium
                      : AppTheme.labelLarge.copyWith(color: AppTheme.secondary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
