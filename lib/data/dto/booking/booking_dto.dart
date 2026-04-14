import 'package:bike_rental_project/model/booking/booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'booking_method_dto.dart';

class BookingDto {
  static const String userIdKey = 'user_id';
  static const String bikeSlotIdKey = 'bike_slot_id';
  static const String createdAtKey = 'created_at';
  static const String bookingStatusKey = 'booking_status';
  static const String bookingMethodKey = 'booking_method';

  static Booking fromJson(
    Map<String, dynamic> json, {
    required String documentId,
  }) {
    assert(json[userIdKey] is String);
    assert(json[bikeSlotIdKey] is String);
    assert(json[createdAtKey] is Timestamp);
    assert(json[bookingStatusKey] is String);
    assert(json[bookingMethodKey] is Map<String, dynamic>);

    return Booking(
      id: documentId,
      userId: json[userIdKey] as String,
      bikeSlotId: json[bikeSlotIdKey] as String,
      createdAt: (json[createdAtKey] as Timestamp).toDate(),
      bookingStatus: BookingStatus.values.byName(
        json[bookingStatusKey] as String,
      ),
      bookingMethod: BookingMethodDto.fromJson(
        json[bookingMethodKey] as Map<String, dynamic>,
      ),
    );
  }

  static Map<String, dynamic> toJson(Booking booking) {
    return {
      userIdKey: booking.userId,
      bikeSlotIdKey: booking.bikeSlotId,
      createdAtKey: Timestamp.fromDate(booking.createdAt),
      bookingStatusKey: booking.bookingStatus.name,
      bookingMethodKey: BookingMethodDto.toJson(booking.bookingMethod),
    };
  }
}
