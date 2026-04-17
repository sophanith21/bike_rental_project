import 'package:bike_rental_project/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:bike_rental_project/data/repositories/booking/booking_repository.dart';
import 'package:bike_rental_project/model/bike/bike_slot.dart';
import 'package:bike_rental_project/model/booking/booking.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

class BookingRepositoryMock implements BookingRepository {
  final BikeSlotRepository bikeSlotRepository;
  final BehaviorSubject<List<Booking>> _allBookingsSubject =
      BehaviorSubject<List<Booking>>.seeded([]);

  BookingRepositoryMock({required this.bikeSlotRepository});

  @override
  Future<void> createNewBooking(Booking newBook) async {
    final currentList = _allBookingsSubject.value;

    final hasOngoing = currentList.any(
      (e) =>
          e.userId == newBook.userId &&
          e.bookingStatus == BookingStatus.ongoing,
    );

    if (hasOngoing) {
      throw Exception("There should only be one booking existing at a time");
    }
    await bikeSlotRepository.updateBikeSlotStatus(
      newBook.bikeSlotId,
      BikeSlotStatus.occupied,
    );
    _allBookingsSubject.add([...currentList, newBook]);
  }

  @override
  Stream<Booking?> getActiveBooking(String userId) {
    return _allBookingsSubject.stream.map((bookings) {
      return bookings.firstWhereOrNull(
        (e) => e.userId == userId && e.bookingStatus == BookingStatus.ongoing,
      );
    }).distinct();
  }

  @override
  Future<void> updateBookingStatus(
    String bookingId,
    BookingStatus newStatus,
  ) async {
    final currentList = _allBookingsSubject.value;
    int targetUpdateIndex = currentList.indexWhere((e) => e.id == bookingId);

    if (targetUpdateIndex != -1) {
      currentList[targetUpdateIndex] = currentList[targetUpdateIndex].copyWith(
        bookingStatus: newStatus,
      );
      _allBookingsSubject.add([...currentList]);
    } else {
      throw Exception(
        "Can't find the booking to update the booking status to complete.",
      );
    }
  }
}
