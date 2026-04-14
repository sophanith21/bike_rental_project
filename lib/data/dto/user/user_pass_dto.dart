import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPassDto {
  static const String userIdKey = 'user_id';
  static const String passSubscriptionIdKey = 'pass_subscription_id';
  static const String startDateKey = 'start_date';
  static const String expirationDateKey = 'expiration_date';
  static const String passStatusKey = 'pass_status';

  static UserPass fromJson(
    Map<String, dynamic> json, {
    required String documentId,
  }) {
    assert(json[userIdKey] is String);
    assert(json[passSubscriptionIdKey] is String);
    assert(json[startDateKey] is Timestamp);
    assert(json[expirationDateKey] is Timestamp);
    assert(json[passStatusKey] is String);

    return UserPass(
      id: documentId,
      userId: json[userIdKey] as String,
      passSubscriptionId: json[passSubscriptionIdKey] as String,
      startDate: (json[startDateKey] as Timestamp).toDate(),
      expirationDate: (json[expirationDateKey] as Timestamp).toDate(),
      passStatus: PassStatus.values.byName(json[passStatusKey] as String),
    );
  }

  static Map<String, dynamic> toJson(UserPass userPass) {
    return {
      userIdKey: userPass.userId,
      passSubscriptionIdKey: userPass.passSubscriptionId,
      startDateKey: Timestamp.fromDate(userPass.startDate),
      expirationDateKey: Timestamp.fromDate(userPass.expirationDate),
      passStatusKey: userPass.passStatus.name,
    };
  }
}
