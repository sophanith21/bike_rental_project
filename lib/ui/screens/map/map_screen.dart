import 'package:bike_rental_project/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:bike_rental_project/data/repositories/bike_station/bike_station_repository.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/ui/screens/map/content/map_content.dart';
import 'package:bike_rental_project/ui/screens/map/view_model/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapViewModel(
        bikeStationRepository: context.read<BikeStationRepository>(),
        bikeSlotRepository: context.read<BikeSlotRepository>(),
        bikeSlotStatus: BikeSlotStatus
            .occupied, // todo change to bookingStatus (complete:parking ui, ongoing:bike ui and null: bike ui)
      ),
      child: const MapContent(),
    );
  }
}
