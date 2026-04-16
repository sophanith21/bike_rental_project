import 'package:bike_rental_project/ui/theme/app_theme.dart';

import 'package:bike_rental_project/ui/widgets/ticket/half_clipper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    super.key,
    required this.topContent,
    required this.bottomContent,
  });

  final Widget topContent;
  final Widget bottomContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primary, width: 2),
        borderRadius: AppTheme.brMedium,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0),
            child: topContent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerRight,
                widthFactor: 0.43,
                child: ClipRect(
                  clipper: HalfClipper(Side.right),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.bgColor,
                      border: Border.all(color: AppTheme.primary, width: 2),
                    ),
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              Expanded(
                child: DottedLine(
                  dashColor: AppTheme.primary,
                  lineThickness: 2,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                widthFactor: 0.43,
                child: ClipRect(
                  clipper: HalfClipper(Side.left),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.bgColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.primary, width: 2),
                    ),
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 16.0),
            child: bottomContent,
          ),
        ],
      ),
    );
  }
}
