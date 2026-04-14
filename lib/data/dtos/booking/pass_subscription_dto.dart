import 'package:bike_rental_project/data/dtos/booking/benefit_dto.dart';
import 'package:bike_rental_project/model/booking/benefit.dart';
import 'package:bike_rental_project/model/booking/pass_subscription.dart';
import 'package:flutter/material.dart';

class PassSubscriptionDto {
  static const String idKey = 'id';
  static const String titleKey = 'title';
  static const String priceKey = 'price';
  static const String coreBenefitsKey = 'coreBenefits';
  static const String validDurationSecondsKey = 'validDurationSeconds';

  static PassSubscription fromJson(String id, Map<String, dynamic> json) {
    assert(json[titleKey] is String);
    assert(json[priceKey] is num);
    assert(json[coreBenefitsKey] is List<dynamic>);
    assert(json[validDurationSecondsKey] is int);

    return PassSubscription(
      id: id,
      title: json[titleKey],
      price: (json[priceKey] as num).toDouble(),
      coreBenefits: (json[coreBenefitsKey] as List<dynamic>)
          .map((e) => BenefitDto.fromJson(e))
          .toList(),
      validDuration: Duration(seconds: json[validDurationSecondsKey]),
    );
  }

  static Map<String, dynamic> toJson(PassSubscription pass) {
    return {
      titleKey: pass.title,
      priceKey: pass.price,
      coreBenefitsKey: pass.coreBenefits
          .map((e) => BenefitDto.toJson(e))
          .toList(),
      validDurationSecondsKey: pass.validDuration.inSeconds,
    };
  }
}
