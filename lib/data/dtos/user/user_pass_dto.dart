import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPassDto {
  static const String userIdKey = 'userId';
  static const String passSubscriptionIdKey = 'passSubscriptionId';
  static const String startDateKey = 'startDate';
  static const String expirationDateKey = 'expirationDate';

  static UserPass fromJson(String id, Map<String, dynamic> json) {
    assert(json[userIdKey] is String);
    assert(json[passSubscriptionIdKey] is String);
    assert(json[startDateKey] is Timestamp);
    assert(json[expirationDateKey] is Timestamp);

    return UserPass(
      id: id,
      userId: json[userIdKey],
      passSubscriptionId: json[passSubscriptionIdKey],
      startDate: (json[startDateKey] as Timestamp).toDate(),
      expirationDate: (json[expirationDateKey] as Timestamp).toDate(),
    );
  }

  static Map<String, dynamic> toJson(UserPass userPass) {
    return {
      userIdKey: userPass.userId,
      passSubscriptionIdKey: userPass.passSubscriptionId,
      startDateKey: Timestamp.fromDate(userPass.startDate),
      expirationDateKey: Timestamp.fromDate(userPass.expirationDate),
    };
  }
}
