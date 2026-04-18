import 'package:bike_rental_project/model/booking/booking_method.dart';

enum BookingStatus { ongoing, complete }

class Booking {
  final String id;
  final String userId;
  final String bikeSlotId;
  final String stationId;
  final String stationName;
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
    required this.stationName,
    required this.stationId,
  });

  Booking copyWith({
    String? id,
    String? userId,
    String? bikeSlotId,
    String? stationId,
    String? stationName,
    DateTime? createdAt,
    BookingStatus? bookingStatus,
    BookingMethod? bookingMethod,
  }) {
    return Booking(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      bikeSlotId: bikeSlotId ?? this.bikeSlotId,
      stationId: stationId ?? this.stationId,
      stationName: stationName ?? this.stationName,
      createdAt: createdAt ?? this.createdAt,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingMethod: bookingMethod ?? this.bookingMethod,
    );
  }

  @override
  String toString() {
    return 'Booking(id: $id, userId: $userId, bikeSlotId: $bikeSlotId, stationId: $stationId, stationName: $stationName createdAt: $createdAt, bookingStatus: $bookingStatus, bookingMethod: $bookingMethod)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Booking &&
        other.id == id &&
        other.userId == userId &&
        other.bikeSlotId == bikeSlotId &&
        other.createdAt == createdAt &&
        other.stationName == stationName &&
        other.bookingStatus == bookingStatus &&
        other.bookingMethod == bookingMethod &&
        other.stationId == stationId;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      userId,
      bikeSlotId,
      stationId,
      createdAt,
      bookingStatus,
      bookingMethod,
      stationName,
    );
  }
}
