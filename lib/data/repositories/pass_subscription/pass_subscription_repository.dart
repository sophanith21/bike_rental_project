import 'package:bike_rental_project/model/booking/pass_subscription.dart';

abstract class PassSubscriptionRepository {
  Future<List<PassSubscription>> getAllPassSubscriptions();
}
