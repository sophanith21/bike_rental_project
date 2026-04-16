import 'package:bike_rental_project/data/repositories/bike_slot/bike_slot_mock_repository.dart';
import 'package:bike_rental_project/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:bike_rental_project/data/repositories/bike_station/bike_station_mock_repository.dart';
import 'package:bike_rental_project/data/repositories/bike_station/bike_station_repository.dart';
import 'package:bike_rental_project/data/repositories/booking/booking_repository.dart';
import 'package:bike_rental_project/data/repositories/booking/booking_repository_mock.dart';
import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository.dart';
import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository_mock.dart';
import 'package:bike_rental_project/data/repositories/user/user_repository.dart';
import 'package:bike_rental_project/data/repositories/user/user_repository_mock.dart';
import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository.dart';
import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository_mock.dart';
import 'package:bike_rental_project/firebase_options.dart';
import 'package:bike_rental_project/ui/my_app.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> dependency = [
  Provider<PassSubscriptionRepository>(
    create: (context) => PassSubscriptionRepositoryMock(),
  ),
  Provider<UserRepository>(create: (context) => UserRepositoryMock()),
  Provider<UserPassRepository>(create: (context) => UserPassRepositoryMock()),
  Provider<BikeSlotRepository>(create: (context) => BikeSlotMockRepository()),
  Provider<BookingRepository>(create: (context) => BookingRepositoryMock()),
  Provider<BikeStationRepository>(
    create: (context) => BikeStationMockRepository(),
  ),
  ChangeNotifierProxyProvider3<
    UserPassRepository,
    UserRepository,
    BookingRepository,
    UserState
  >(
    create: (BuildContext context) {
      return UserState(
        userPassRepository: context.read<UserPassRepository>(),
        userRepository: context.read<UserRepository>(),
        bookingRepository: context.read<BookingRepository>(),
      );
    },
    update:
        (
          BuildContext context,
          UserPassRepository value,
          UserRepository value2,
          BookingRepository value3,
          UserState? previous,
        ) {
          if (previous != null) return previous;
          return UserState(
            userPassRepository: value,
            userRepository: value2,
            bookingRepository: value3,
          );
        },
  ),
];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(dependencies: dependency));
}
