import 'dart:async';

import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository.dart';
import 'package:bike_rental_project/data/sources/seed_data.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

class UserPassRepositoryMock implements UserPassRepository {
  final List<UserPass> _userPassList = SeedData.userPasses;

  final BehaviorSubject<UserPass?> _activePassSubject =
      BehaviorSubject<UserPass?>();

  @override
  Stream<UserPass?> getActiveUserPass(String userId) {
    // Check for the existing active pass immediately
    final result = _userPassList.firstWhereOrNull(
      (e) => e.userId == userId && e.passStatus == PassStatus.active,
    );

    // Seed the subject with the current state
    _activePassSubject.add(result);

    return _activePassSubject.stream;
  }

  @override
  Future<UserPass> createUserPass(UserPass newUserPass) async {
    final existing = _userPassList.firstWhereOrNull(
      (e) =>
          e.userId == newUserPass.userId && e.passStatus == PassStatus.active,
    );

    if (existing == null) {
      _userPassList.add(newUserPass);
      _activePassSubject.add(newUserPass);
      return newUserPass;
    } else {
      throw Exception("User already has an active pass.");
    }
  }
}
