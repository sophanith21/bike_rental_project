import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BikeRentalDialog extends StatelessWidget {
  final String title;
  final String description;
  final Widget? action;
  const BikeRentalDialog({
    super.key,
    required this.title,
    this.action,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        clipBehavior: Clip.none,

        children: [
          Positioned.fill(
            top: 10,
            left: 10,
            right: -10,
            bottom: -10,
            child: Container(
              width: 380,
              decoration: BoxDecoration(
                color: AppTheme.accent,
                border: Border.all(color: AppTheme.primary),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            width: 380,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primary),
              borderRadius: AppTheme.brMedium,
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: AppTheme.headlineMedium),
                SizedBox(
                  width: 210,
                  child: Divider(thickness: 2, color: AppTheme.primary),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(description, style: AppTheme.bodyMedium),
                ),
                SizedBox(height: 40),

                ?action,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
