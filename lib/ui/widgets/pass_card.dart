import 'package:bike_rental_project/model/booking/benefit.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:bike_rental_project/ui/widgets/ticket/ticket_widget.dart';
import 'package:flutter/material.dart';

class PassCard extends StatelessWidget {
  final bool isActive; // Is the pass the current user active pass?
  final String title;
  final List<Benefit> coreBenefits;
  final Widget? action;
  const PassCard({
    super.key,
    required this.title,
    required this.coreBenefits,
    this.action,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = TicketWidget(
      topContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text(title, style: AppTheme.titleLarge),
          SizedBox(height: 17),
          ...coreBenefits.map(
            (benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                spacing: 10,
                children: [
                  Icon(benefit.iconData, color: AppTheme.secondary),
                  Text(
                    benefit.label,
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

    return isActive
        ? Banner(
            message: 'Active Pass',
            location: BannerLocation.topEnd, // top right corner
            color: Colors.red,
            child: child,
          )
        : child;
  }
}
