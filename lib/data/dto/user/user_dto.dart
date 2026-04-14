import 'package:bike_rental_project/model/user/user.dart';

class UserDto {
  static const String nameKey = 'name';

  static User fromJson(
    Map<String, dynamic> json, {
    required String documentId,
  }) {
    assert(json[nameKey] is String);

    return User(id: documentId, name: json[nameKey] as String);
  }

  static Map<String, dynamic> toJson(User user) {
    return {nameKey: user.name};
  }
}
