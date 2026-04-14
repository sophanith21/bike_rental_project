import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository.dart';
import 'package:bike_rental_project/model/booking/pass_subscription.dart';
import 'package:material_symbols_icons/symbols.dart';

class PassSubscriptionRepositoryMock implements PassSubscriptionRepository {
  final List<PassSubscription> passSubscriptions = [
    PassSubscription(
      id: "1",
      title: "Daily Explorer",
      price: 2.0,
      coreBenefits: {
        Symbols.nest_clock_farsight_analog: "Unlimited 30mins ride",
        Symbols.calendar_check: "Valid for 24 hours",
        Symbols.pedal_bike_rounded: "Quick \"Grab & Go\" access",
      },
      validDuration: Duration(days: 1),
    ),
    PassSubscription(
      id: "2",
      title: "Monthly Habit",
      price: 15.0,
      coreBenefits: {
        Symbols.nest_clock_farsight_analog: "Unlimited 30mins ride",
        Symbols.calendar_check: "Valid for 1 month (30 days)",
        Symbols.pedal_bike_rounded: "Quick \"Grab & Go\" access",
      },
      validDuration: Duration(days: 30),
    ),
    PassSubscription(
      id: "3",
      title: "Annual Member",
      price: 99.00,
      coreBenefits: {
        Symbols.nest_clock_farsight_analog: "Unlimited 30mins ride",
        Symbols.calendar_check: "Valid for 12 months (365 days)",
        Symbols.pedal_bike_rounded: "Quick \"Grab & Go\" access",
      },
      validDuration: Duration(days: 365),
    ),
  ];
  @override
  Future<List<PassSubscription>> getAllPassSubscriptions() async {
    return passSubscriptions;
  }
}
