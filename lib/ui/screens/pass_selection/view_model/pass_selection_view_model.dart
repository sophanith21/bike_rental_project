import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository.dart';
import 'package:bike_rental_project/model/booking/pass_subscription.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:bike_rental_project/ui/utils/async_value.dart';
import 'package:flutter/material.dart';

class PassSelectionViewModel extends ChangeNotifier {
  final UserState userState;
  final PassSubscriptionRepository passSubscriptionRepository;

  PassSelectionViewModel({
    required this.userState,
    required this.passSubscriptionRepository,
  }) {
    init();
  }

  void init() async {
    try {
      passSubscriptionsAsyncValue = AsyncValue.success(
        await passSubscriptionRepository.getAllPassSubscriptions(),
      );
    } catch (err) {
      passSubscriptionsAsyncValue = AsyncValue.error(err);
    } finally {
      notifyListeners();
    }
  }

  AsyncValue<List<PassSubscription>> passSubscriptionsAsyncValue =
      AsyncValue.loading();

  bool get isSubscriptionActive => userState.userPass != null;

  UserPass? get activePass => userState.userPass;
}
