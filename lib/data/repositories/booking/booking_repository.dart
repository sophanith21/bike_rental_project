import 'package:bike_rental_project/model/booking/booking.dart';

abstract class BookingRepository {
  Stream<Booking?> getActiveBooking(String userId);
  Future<void> createNewBooking(Booking newBook);
  Future<void> updateBookingStatus(String bookingId, BookingStatus newStatus);
}
