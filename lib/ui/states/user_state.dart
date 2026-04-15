import 'dart:async';

import 'package:bike_rental_project/data/repositories/user/user_repository.dart';
import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository.dart';
import 'package:bike_rental_project/model/user/user.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  final UserPassRepository userPassRepository;
  final UserRepository userRepository;
  bool isDisposed = false;

  Timer? expirationTimer;
  StreamSubscription<UserPass?>? userPassStreamSubscription;

  User? user;
  UserPass? userPass;
  UserState({
    this.user,
    this.userPass,
    required this.userPassRepository,
    required this.userRepository,
  }) {
    init();
  }

  Future<void> init() async {
    user = await userRepository.getUser(
      "Allya",
      "",
    ); // This is done for testing only
    if (user != null) {
      userPassStreamSubscription = userPassRepository
          .getActiveUserPass(user!.id)
          .listen(
            (data) {
              expirationTimer?.cancel();

              if (data == null) {
                userPass = null;
              } else {
                Duration remainingTime = data.expirationDate.difference(
                  DateTime.now(),
                );
                userPass = data;
                expirationTimer = Timer(remainingTime, () {
                  userPass = null;
                  notifyListeners();
                });
              }
              if (!isDisposed) notifyListeners();
            },
            onError: (err) {
              if (!isDisposed) notifyListeners();
            },
          );
    }
    if (!isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    userPassStreamSubscription?.cancel();
    expirationTimer?.cancel();
    isDisposed = true;
    super.dispose();
  }

  Future<void> login(String username, String password) async {
    user = await userRepository.getUser(username, password);
  }

  Future<void> updateUser(User updatedUser) async {
    if (user != updatedUser) {
      user = updatedUser;
      notifyListeners();
    }
  }

  Future<void> updateUserPass(UserPass updatedUserPass) async {
    if (userPass != updatedUserPass) {
      await userPassRepository.createUserPass(updatedUserPass);
    }
  }
}
