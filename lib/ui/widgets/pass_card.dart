import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/ui/widgets/ticket/ticket_widget.dart';
import 'package:flutter/material.dart';

class PassCard extends StatelessWidget {
  final String title;
  final Map<IconData, String> coreBenefits;
  final Widget? action;
  const PassCard({
    super.key,
    required this.title,
    required this.coreBenefits,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return TicketWidget(
      topContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text(title, style: AppTheme.titleLarge),
          SizedBox(height: 17),
          ...coreBenefits.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                spacing: 10,
                children: [
                  Icon(entry.key, color: AppTheme.secondary),
                  Text(
                    entry.value,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomContent: action ?? SizedBox.shrink(),
    );
  }
}
