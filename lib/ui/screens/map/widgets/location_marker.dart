import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LocationMarker extends StatelessWidget {
  const LocationMarker({
    super.key,
    required this.count,
    required this.status,
    required this.isSelected,
  });

  final int count;
  final bool isSelected;
  final BikeSlotStatus status;

  Color get pinColor =>
      status == BikeSlotStatus.empty ? AppTheme.accent2 : AppTheme.secondary;

  List<Shadow> get markerOutlined => isSelected
      ? [
          Shadow(offset: Offset(-1.5, -1.5), color: AppTheme.primary),
          Shadow(offset: Offset(1.5, -1.5), color: AppTheme.primary),
          Shadow(offset: Offset(1.5, 1.5), color: AppTheme.primary),
          Shadow(offset: Offset(-1.5, 1.5), color: AppTheme.primary),
        ]
      : [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Icon(
          Icons.location_on_rounded,
          color: pinColor,
          size: 70,
          shadows: markerOutlined,
        ),

        Positioned(
          top: 10,
          left: 15,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primary, width: 3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$count',
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    height: 1,
                  ),
                ),
                status == BikeSlotStatus.empty
                    ? Icon(
                        Icons.local_parking_rounded,
                        color: AppTheme.primary,
                        size: 18,
                      )
                    : Icon(
                        Icons.pedal_bike_rounded,
                        color: AppTheme.primary,
                        size: 18,
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
