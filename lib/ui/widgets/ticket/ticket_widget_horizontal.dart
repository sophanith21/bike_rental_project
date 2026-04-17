import 'package:bike_rental_project/ui/theme/app_theme.dart';

import 'package:bike_rental_project/ui/widgets/ticket/half_clipper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class TicketWidgetHorizontal extends StatelessWidget {
  const TicketWidgetHorizontal({
    super.key,
    required this.leftContent,
    required this.rightContent,
  });

  final Widget leftContent;
  final Widget rightContent;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.brMedium,
          border: Border.all(color: AppTheme.primary, width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Side
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: leftContent,
              ),
            ),

            // The Vertical Divider
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top Punch
                Align(
                  alignment: Alignment.bottomCenter,
                  widthFactor: 0.5,
                  heightFactor: 0.43,
                  child: ClipRect(
                    clipper: HalfClipper(Side.bottom),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.primary, width: 2),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),

                // Dashed Line
                Expanded(
                  child: DottedLine(
                    direction: Axis.vertical,
                    lineLength: 50,
                    dashColor: AppTheme.primary,
                    lineThickness: 2,
                  ),
                ),

                // Bottom Punch
                Align(
                  alignment: Alignment.topCenter,
                  widthFactor: 0.5,
                  heightFactor: 0.43,
                  child: ClipRect(
                    clipper: HalfClipper(Side.top),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.primary, width: 2),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),

            // Right Side
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: rightContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
