import 'package:mocktail/mocktail.dart';
import 'package:bike_rental_project/data/repositories/user/user_repository.dart';
import 'package:bike_rental_project/data/repositories/user_pass/user_pass_repository.dart';
import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockUserPassRepository extends Mock implements UserPassRepository {}

class MockPassSubRepository extends Mock
    implements PassSubscriptionRepository {}

class MockUserState extends Mock implements UserState {}

// Fallback for Mocktail to handle custom objects in 'any()'
class FakeUserPass extends Fake implements UserPass {}

void registerTestFallbacks() {
  registerFallbackValue(
    UserPass(
      id: '',
      userId: '',
      startDate: DateTime.now(),
      expirationDate: DateTime.now(),
      passSubscriptionId: '',
    ),
  );
}
