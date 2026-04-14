import 'package:bike_rental_project/data/repositories/user/user_repository.dart';
import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository.dart';
import 'package:bike_rental_project/model/user/user.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  final UserPassRepository userPassRepository;
  final UserRepository userRepository;
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
      "alice",
      "",
    ); // This is done for testing
    if (user != null) {
      userPass = await userPassRepository.getActiveUserPass(user!.id);
    }
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
      userPass = await userPassRepository.createUserPass(updatedUserPass);
      notifyListeners();
    }
  }
}
