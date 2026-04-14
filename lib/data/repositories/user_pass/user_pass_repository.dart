import 'package:bike_rental_project/model/user/user_pass.dart';

abstract class UserPassRepository {
  Future<UserPass?> getActiveUserPass(String userId);
  Future<UserPass> createUserPass(UserPass newUserPass);
}
