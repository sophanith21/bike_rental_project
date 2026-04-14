import 'package:bike_rental_project/model/booking/booking_method.dart';

class BookingMethodDto {
  static const String passIdKey = 'pass_id';
  static const String rentDateKey = 'rent_date';
  static const String priceKey = 'price';
  static const String bookingTypeKey = 'booking_type';

  static BookingMethod fromJson(Map<String, dynamic> json) {
    assert(json[passIdKey] is String);
    assert(json[rentDateKey] is String);
    assert(json[priceKey] is num);
    assert(json[bookingTypeKey] is String);

    return BookingMethod(
      passId: json[passIdKey] as String,
      rentDate: json[rentDateKey] as String,
      price: (json[priceKey] as num).toDouble(),
      bookingType: BookingType.values.byName(json[bookingTypeKey] as String),
    );
  }

  static Map<String, dynamic> toJson(BookingMethod bookingMethod) {
    return {
      passIdKey: bookingMethod.passId,
      rentDateKey: bookingMethod.rentDate,
      priceKey: bookingMethod.price,
      bookingTypeKey: bookingMethod.bookingType.name,
    };
  }
}
