import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileViewModel extends ChangeNotifier {
  UserState userState;
  ProfileViewModel({required this.userState});

  void updateUserState(UserState newUserState) {
    userState = newUserState;
    notifyListeners();
  }

  bool get isPassActive =>
      userState.userPass != null &&
      userState.userPass!.passStatus == PassStatus.active;
  String? get username => userState.user?.name;
  String? get userPassName => userState.userPass?.passName;
  String? get endDate => isPassActive
      ? DateFormat(
          "dd MMM yyyy, hh:mm a",
        ).format(userState.userPass!.expirationDate)
      : null;
}
