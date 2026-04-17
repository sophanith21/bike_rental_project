import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/bike/bike_station.dart';
import 'package:bike_rental_project/model/booking/booking.dart';
import 'package:bike_rental_project/model/booking/booking_method.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ReleaseBikeViewModel extends ChangeNotifier {
  final BikeSlot selectedBikeSlot;
  final BikeStation selectedStation;
  UserState userState;

  ReleaseBikeViewModel({
    required this.selectedBikeSlot,
    required this.selectedStation,
    required this.userState,
  });

  AsyncValue<bool>? bookingProcessStatus;
  AsyncValue<bool>? releaseBikeStatus;

  void updateUserState(UserState newUserState) {
    userState = newUserState;
    notifyListeners();
  }

  UserPass? get userPass => userState.userPass;

  bool get isSubscriptionActive {
    final userPass = userState.userPass;
    if (userPass == null) return false;
    if (userPass.passStatus != PassStatus.active) return false;
    return true;
  }

  bool get hasBookedAlready {
    if (userState.booking == null) return false;
    if (userState.booking!.bookingStatus != BookingStatus.ongoing) return false;
    return true;
  }

  bool get isBookingTheSlot {
    if (userState.booking == null) return false;
    if (userState.booking!.bikeSlotId != selectedBikeSlot.id) return false;
    if (userState.booking!.bookingStatus != BookingStatus.ongoing) return false;
    return true;
  }

  String get payLabel {
    if (isBookingTheSlot) return "Release the bike";
    if (hasBookedAlready) return "One booking already existed";
    if (isSubscriptionActive) {
      return "Book the bike";
    }
    if (bookingProcessStatus?.state == AsyncValueState.loading) {
      return "Processing";
    }
    return "Pay \$${selectedStation.bikeRentPrice.toStringAsFixed(2)}";
  }

  Future<void> onBikeBooked() async {
    try {
      bookingProcessStatus = AsyncValue.loading();
      notifyListeners();
      BookingMethod method = isSubscriptionActive
          ? BookingMethod(
              passId: userPass!.id,
              rentDate: DateTime.now(),
              price: 0,
              bookingType: BookingType.pass,
            )
          : BookingMethod(
              passId: null,
              rentDate: DateTime.now(),
              price: selectedStation.bikeRentPrice,
              bookingType: BookingType.oneTime,
            );
      Booking newBook = Booking(
        id: Uuid().v4(),
        createdAt: DateTime.now(),
        bookingMethod: method,
        userId: userState.user!.id,
        bikeSlotId: selectedBikeSlot.id,
        bookingStatus: BookingStatus.ongoing,
        stationName: selectedStation.stationName,
        stationId: selectedStation.id,
      );
      await userState.createBooking(newBook);
      bookingProcessStatus = AsyncValue.success(true);
    } catch (err) {
      bookingProcessStatus = AsyncValue.error(err);
    } finally {
      notifyListeners();
    }
  }

  Future<void> releaseBike() async {
    try {
      releaseBikeStatus = AsyncValue.loading();
      notifyListeners();

      await userState.updateBookingStatus(
        userState.booking!.id,
        BookingStatus.complete,
      );
      userState.isRelease = true;
      releaseBikeStatus = AsyncValue.success(true);
    } catch (err) {
      releaseBikeStatus = AsyncValue.error(err);
    } finally {
      notifyListeners();
    }
  }
}
