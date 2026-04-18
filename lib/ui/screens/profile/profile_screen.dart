import 'package:bike_rental_project/ui/screens/profile/view_model/profile_view_model.dart';
import 'package:bike_rental_project/ui/screens/profile/widgets/profile_content.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<UserState, ProfileViewModel>(
      create: (context) =>
          ProfileViewModel(userState: context.read<UserState>()),
      update: (context, value, previous) {
        if (previous != null) {
          previous.updateUserState(value);
          return previous;
        }
        return ProfileViewModel(userState: value);
      },
      child: ProfileContent(),
    );
  }
}
