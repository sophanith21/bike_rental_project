import 'package:bike_rental_project/model/booking/booking_method.dart';

enum BookingStatus { ongoing, complete }

class Booking {
  final String id;
  final String userId;
  final String bikeSlotId;
  final DateTime createdAt;
  final BookingStatus bookingStatus;
  final BookingMethod bookingMethod;

  const Booking({
    required this.id,
    required this.createdAt,
    required this.bookingMethod,
    required this.userId,
    required this.bikeSlotId,
    required this.bookingStatus,
  });
}
