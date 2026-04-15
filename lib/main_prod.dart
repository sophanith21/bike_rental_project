import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository.dart';
import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository_prod.dart';
import 'package:bike_rental_project/data/repositories/user/user_repository.dart';
import 'package:bike_rental_project/data/repositories/user/user_repository_prod.dart';
import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository.dart';
import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository_prod.dart';
import 'package:bike_rental_project/firebase_options.dart';
import 'package:bike_rental_project/ui/my_app.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> dependency = [
  Provider<PassSubscriptionRepository>(
    create: (context) => PassSubscriptionRepositoryProd(),
  ),
  Provider<UserRepository>(create: (context) => UserRepositoryProd()),
  Provider<UserPassRepository>(create: (context) => UserPassRepositoryProd()),
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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(dependencies: dependency));
}
