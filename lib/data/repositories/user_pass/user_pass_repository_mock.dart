import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository.dart';
import 'package:bike_rental_project/data/sources/seed_data.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:collection/collection.dart';

class UserPassRepositoryMock implements UserPassRepository {
  List<UserPass> userPassList = SeedData.userPasses;
  @override
  Stream<UserPass?> getActiveUserPass(String userId) {
    final result = userPassList.firstWhereOrNull(
      (e) => e.userId == userId && e.passStatus == PassStatus.active,
    );

    return Stream.value(result);
  }

  @override
  Future<UserPass> createUserPass(UserPass newUserPass) async {
    final result = userPassList.firstWhereOrNull(
      (e) =>
          e.userId == newUserPass.userId && e.passStatus == PassStatus.active,
    );
    if (result == null) {
      userPassList.add(newUserPass);
      return newUserPass;
    } else {
      throw Exception(
        "User should only have one pass active (Make sure to prevent this issue)",
      );
    }
  }
}
