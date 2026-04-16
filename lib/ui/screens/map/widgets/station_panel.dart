import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class StationDetailsPanel extends StatelessWidget {
  final BikeStation station;
  final BikeSlotStatus status;
  final ScrollController scrollController;
  final VoidCallback onDeselect;
  final ValueChanged<BikeSlot> onBooked;
  final List<BikeSlot> bikeSlots;

  const StationDetailsPanel({
    super.key,
    required this.station,
    required this.scrollController,
    required this.status,
    required this.onDeselect,
    required this.bikeSlots,
    required this.onBooked,
  });

  Color get colorStatus =>
      status == BikeSlotStatus.empty ? AppTheme.accent2 : AppTheme.secondary;

  IconData get iconStatus => status == BikeSlotStatus.empty
      ? Icons.local_parking_rounded
      : Icons.pedal_bike_rounded;

  String get labelTitle =>
      status == BikeSlotStatus.empty ? "Parking Available" : "Available bikes";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: AppTheme.primary),
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
      ),
      child: ListView(
        controller: scrollController,
        // physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  station.stationName,
                  style: const TextStyle(
                    fontSize: AppTheme.rLarge,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
              ),

              Icon(
                Icons.bike_scooter_rounded,
                size: 50,
                color: AppTheme.primary,
              ),

              IconButton(
                onPressed: onDeselect,
                icon: Icon(Icons.cancel_outlined, color: AppTheme.primary),
              ),
            ],
          ),
          const Divider(height: 40, color: AppTheme.primary, thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: colorStatus, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(iconStatus, size: 35, color: colorStatus),
                    const SizedBox(width: 20),
                    Text(
                      labelTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: colorStatus,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "${bikeSlots.length}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppTheme.rLarge,
                        color: colorStatus,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.primary, width: 2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Slots",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 90),
                    Text(
                      "Status",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 24,
                  color: AppTheme.primary,
                  thickness: 2,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bikeSlots.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 24,
                    color: AppTheme.primary,
                    thickness: 2,
                  ),
                  itemBuilder: (context, index) {
                    final slot = bikeSlots[index];
                    return buildSlotItem(slot, onBooked);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlotItem(BikeSlot slot, ValueChanged<BikeSlot> onBooked) {
    return GestureDetector(
      onTap: () => onBooked(slot),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border.all(color: colorStatus),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "Slots ${slot.slotNumber.toString().padLeft(2, '0')}",
              style: TextStyle(fontSize: 16, color: colorStatus),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: colorStatus),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available",
                    style: TextStyle(
                      color: colorStatus,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Icon(iconStatus, size: 35, color: colorStatus),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
