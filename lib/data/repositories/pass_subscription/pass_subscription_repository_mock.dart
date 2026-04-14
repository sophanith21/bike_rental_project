import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository.dart';
import 'package:bike_rental_project/data/sources/seed_data.dart';
import 'package:bike_rental_project/model/booking/pass_subscription.dart';

class PassSubscriptionRepositoryMock implements PassSubscriptionRepository {
  final List<PassSubscription> passSubscriptions = SeedData.passes;
  @override
  Future<List<PassSubscription>> getAllPassSubscriptions() async {
    return passSubscriptions;
  }
}
