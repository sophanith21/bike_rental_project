import 'package:bike_rental_project/data/repositories/pass_subscription/pass_subscription_repository.dart';
import 'package:bike_rental_project/model/booking/pass_subscription.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class PassSelectionViewModel extends ChangeNotifier {
  UserState userState;
  final PassSubscriptionRepository passSubscriptionRepository;
  bool isDisposed = false;
  PassSelectionViewModel({
    required this.userState,
    required this.passSubscriptionRepository,
  }) {
    init();
  }
  void updateUserState(UserState newUserState) {
    userState = newUserState;
    notifyListeners();
  }

  void init() async {
    try {
      passSubscriptionsAsyncValue = AsyncValue.success(
        await passSubscriptionRepository.getAllPassSubscriptions(),
      );
    } catch (err) {
      passSubscriptionsAsyncValue = AsyncValue.error(err);
    } finally {
      if (!isDisposed) notifyListeners();
    }
  }

  AsyncValue<List<PassSubscription>> passSubscriptionsAsyncValue =
      AsyncValue.loading();

  List<PassSubscription> get sortedPassSubscriptions {
    final data = passSubscriptionsAsyncValue.data ?? [];
    if (!isSubscriptionActive) return data;

    final active = data.firstWhereOrNull(
      (e) => e.id == activePass?.passSubscriptionId,
    );
    if (active == null) return data;

    return [active, ...data.where((e) => e.id != active.id)];
  }

  bool get isSubscriptionActive =>
      userState.userPass != null &&
      userState.userPass!.passStatus == PassStatus.active;

  UserPass? get activePass => userState.userPass;

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
