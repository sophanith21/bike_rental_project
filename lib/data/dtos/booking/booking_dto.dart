import 'package:bike_rental_project/data/dtos/booking/booking_method_dto.dart';
import 'package:bike_rental_project/model/booking/booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDto {
  static const String userIdKey = 'userId';
  static const String bikeSlotIdKey = 'bikeSlotId';
  static const String stationIdKey = 'stationId';
  static const String createdAtKey = 'createdAt';
  static const String bookingStatusKey = 'bookingStatus';
  static const String bookingMethodKey = 'bookingMethod';
  static const String stationNameKey = 'stationName';

  static Booking fromJson(String id, Map<String, dynamic> json) {
    assert(json[userIdKey] is String);
    assert(json[bikeSlotIdKey] is String);
    assert(json[stationIdKey] is String);
    assert(json[createdAtKey] is Timestamp);
    assert(json[bookingStatusKey] is String);
    assert(json[bookingMethodKey] is Map);
    assert(json[stationNameKey] is String);

    return Booking(
      id: id,
      userId: json[userIdKey],
      bikeSlotId: json[bikeSlotIdKey],
      createdAt: (json[createdAtKey] as Timestamp).toDate(),
      bookingStatus: BookingStatus.values.byName(json[bookingStatusKey]),
      bookingMethod: BookingMethodDto.fromJson(
        Map<String, dynamic>.from(json[bookingMethodKey]),
      ),
      stationName: json[stationNameKey],
      stationId: json[stationIdKey],
    );
  }

  static Map<String, dynamic> toJson(Booking booking) {
    return {
      userIdKey: booking.userId,
      bikeSlotIdKey: booking.bikeSlotId,
      createdAtKey: Timestamp.fromDate(booking.createdAt),
      bookingStatusKey: booking.bookingStatus.name,
      bookingMethodKey: BookingMethodDto.toJson(booking.bookingMethod),
      stationNameKey: booking.stationName,
      stationIdKey: booking.stationId,
    };
  }
}
