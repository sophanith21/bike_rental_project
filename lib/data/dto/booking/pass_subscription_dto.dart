import 'package:bike_rental_project/model/booking/pass_subscription.dart';

class PassSubscriptionDto {
  static const String titleKey = 'title';
  static const String descriptionKey = 'description';
  static const String priceKey = 'price';
  static const String validDurationDaysKey =
      'valid_duration_days'; // stored as int

  static PassSubscription fromJson(
    Map<String, dynamic> json, {
    required String documentId,
  }) {
    assert(json[titleKey] is String);
    assert(json[descriptionKey] is String);
    assert(json[priceKey] is num);
    assert(json[validDurationDaysKey] is int);

    return PassSubscription(
      id: documentId,
      title: json[titleKey] as String,
      description: json[descriptionKey] as String,
      price: (json[priceKey] as num).toDouble(),
      validDuration: Duration(days: json[validDurationDaysKey] as int),
    );
  }

  static Map<String, dynamic> toJson(PassSubscription pass) {
    return {
      titleKey: pass.title,
      descriptionKey: pass.description,
      priceKey: pass.price,
      validDurationDaysKey: pass.validDuration.inDays,
    };
  }
}
