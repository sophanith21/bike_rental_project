import 'package:bike_rental_project/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/ui/screens/release_bike/view_model/release_bike_view_model.dart';
import 'package:bike_rental_project/ui/screens/release_bike/widgets/release_bike_content.dart';
import 'package:bike_rental_project/ui/screens/return_bike/view_model/return_bike_view_model.dart';
import 'package:bike_rental_project/ui/screens/return_bike/widgets/return_bike_content.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReturnBikeScreen extends StatelessWidget {
  final BikeSlot slot;
  final BikeStation station;
  const ReturnBikeScreen({
    super.key,
    required this.slot,
    required this.station,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<UserState, ReturnBikeViewModel>(
      create: (context) => ReturnBikeViewModel(
        selectedBikeSlot: slot,
        selectedStation: station,
        userState: context.read<UserState>(),
        bikeSlotRepository: context.read<BikeSlotRepository>(),
      ),
      update:
          (
            BuildContext context,
            UserState value,
            ReturnBikeViewModel? previous,
          ) {
            if (previous != null) {
              previous.updateUserState(value);

              return previous;
            }
            return ReturnBikeViewModel(
              selectedBikeSlot: slot,
              selectedStation: station,
              userState: value,
              bikeSlotRepository: context.read<BikeSlotRepository>(),
            );
          },
      child: ReturnBikeContent(),
    );
  }
}
