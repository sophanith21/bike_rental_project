import 'package:bike_rental_project/model/booking/booking_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingMethodDto {
  static const String passIdKey = 'passId';
  static const String rentDateKey = 'rentDate';
  static const String priceKey = 'price';
  static const String bookingTypeKey = 'bookingType';

  static BookingMethod fromJson(Map<String, dynamic> json) {
    assert(json[rentDateKey] is Timestamp);
    assert(json[priceKey] is num);
    assert(json[bookingTypeKey] is String);

    return BookingMethod(
      passId: json[passIdKey] as String?,
      // Convert Firestore Timestamp to Dart DateTime
      rentDate: (json[rentDateKey] as Timestamp).toDate(),
      price: (json[priceKey] as num).toDouble(),
      bookingType: BookingType.values.byName(json[bookingTypeKey]),
    );
  }

  static Map<String, dynamic> toJson(BookingMethod bookingMethod) {
    return {
      passIdKey: bookingMethod.passId,
      rentDateKey: Timestamp.fromDate(bookingMethod.rentDate),
      priceKey: bookingMethod.price,
      bookingTypeKey: bookingMethod.bookingType.name,
    };
  }
}
