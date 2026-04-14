import 'package:bike_rental_project/model/user/user.dart';

abstract class UserRepository {
  Future<User?> getUser(String username, String password); // Testing only
}
