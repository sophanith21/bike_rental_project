import 'package:bike_rental_project/data/repositories/user/user_repository.dart';
import 'package:bike_rental_project/data/sources/seed_data.dart';
import 'package:bike_rental_project/model/user/user.dart';
import 'package:collection/collection.dart';

class UserRepositoryMock implements UserRepository {
  final List<User> users = SeedData.users;
  @override
  Future<User?> getUser(String username, String password) async {
    return users.firstWhereOrNull(
      (e) => e.name.toLowerCase() == username.toLowerCase(),
    );
  }
}
