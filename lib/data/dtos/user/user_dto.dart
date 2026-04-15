import 'package:bike_rental_project/model/user/user.dart';

class UserDto {
  static const String nameKey = 'name';

  static User fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);

    return User(id: id, name: json[nameKey]);
  }

  static Map<String, dynamic> toJson(User user) {
    return {nameKey: user.name};
  }
}
