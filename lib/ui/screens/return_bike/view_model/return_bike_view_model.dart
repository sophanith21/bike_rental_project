import 'package:bike_rental_project/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/model/booking/booking.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:flutter/material.dart';

class ReturnBikeViewModel extends ChangeNotifier {
  final BikeSlotRepository bikeSlotRepository;
  final BikeSlot selectedBikeSlot;
  final BikeStation selectedStation;
  UserState userState;

  ReturnBikeViewModel({
    required this.selectedBikeSlot,
    required this.selectedStation,
    required this.userState,
    required this.bikeSlotRepository,
  });

  AsyncValue<bool>? returnBikeStatus;

  void updateUserState(UserState newUserState) {
    userState = newUserState;
    notifyListeners();
  }

  UserPass? get userPass => userState.userPass;

  Future<void> returnBike() async {
    try {
      returnBikeStatus = AsyncValue.loading();
      notifyListeners();
      await bikeSlotRepository.updateBikeSlotStatus(
        selectedBikeSlot.id,
        BikeSlotStatus.occupied,
      );
      userState.isRelease = false;
      returnBikeStatus = AsyncValue.success(true);
    } catch (err) {
      returnBikeStatus = AsyncValue.error(err);
    } finally {
      notifyListeners();
    }
  }
}
