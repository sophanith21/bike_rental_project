import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:flutter/material.dart';

class ReleaseBikeViewModel extends ChangeNotifier {
  final BikeSlot selectedBikeSlot;
  final BikeStation selectedStation;
  final UserState userState;

  ReleaseBikeViewModel({
    required this.selectedBikeSlot,
    required this.selectedStation,
    required this.userState,
  });

  UserPass? get userPass => userState.userPass;

  bool get isSubscriptionActive {
    final userPass = userState.userPass;
    if (userPass == null) return false;
    if (userPass.passStatus != PassStatus.active) return false;
    return true;
  }

  String get payLabel {
    if (isSubscriptionActive) return "Book the bike";
    return "Pay \$${selectedStation.bikeRentPrice.toStringAsFixed(2)}";
  }
}
