import 'dart:ui';

import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BikeRentalButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isFilled;

  const BikeRentalButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isFilled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: AppTheme.brLarge,
          border: Border.all(color: AppTheme.primary, width: 2),
          color: isFilled ? AppTheme.primary : AppTheme.bgColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 4,
            ),
          ],
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: AppTheme.brLarge, // ripple respects the border radius
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            child: Center(
              child: Text(
                label,
                style: AppTheme.labelLarge.copyWith(
                  color: isFilled ? AppTheme.bgColor : AppTheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
