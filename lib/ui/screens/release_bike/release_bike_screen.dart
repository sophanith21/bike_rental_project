import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/ui/screens/release_bike/view_model/release_bike_view_model.dart';
import 'package:bike_rental_project/ui/screens/release_bike/widgets/release_bike_content.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReleaseBikeScreen extends StatelessWidget {
  final BikeSlot slot;
  final BikeStation station;
  const ReleaseBikeScreen({
    super.key,
    required this.slot,
    required this.station,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReleaseBikeViewModel(
        selectedBikeSlot: slot,
        selectedStation: station,
        userState: context.read<UserState>(),
      ),
      child: ReleaseBikeContent(),
    );
  }
}
