import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository.dart';
import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository_mock.dart';
import 'package:bike_rental_project/data/repositories/user/user_repository.dart';
import 'package:bike_rental_project/data/repositories/user/user_repository_mock.dart';
import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository.dart';
import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository_mock.dart';
import 'package:bike_rental_project/ui/my_app.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> dependency = [
  Provider<PassSubscriptionRepository>(
    create: (context) => PassSubscriptionRepositoryMock(),
  ),
  Provider<UserRepository>(create: (context) => UserRepositoryMock()),
  Provider<UserPassRepository>(create: (context) => UserPassRepositoryMock()),
  ChangeNotifierProxyProvider2<UserPassRepository, UserRepository, UserState>(
    create: (BuildContext context) {
      return UserState(
        userPassRepository: context.read<UserPassRepository>(),
        userRepository: context.read<UserRepository>(),
      );
    },
    update:
        (
          BuildContext context,
          UserPassRepository value,
          UserRepository value2,
          UserState? previous,
        ) {
          return UserState(userPassRepository: value, userRepository: value2);
        },
  ),
];
void main() {
  runApp(MyApp(dependencies: dependency));
}
