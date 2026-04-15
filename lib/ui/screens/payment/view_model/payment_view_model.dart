import 'package:bike_rental_project/model/booking/pass_subscription.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PaymentViewModel extends ChangeNotifier {
  final PassSubscription selectedSubs;
  final UserState userState;

  PaymentViewModel({required this.selectedSubs, required this.userState});

  AsyncValue<bool>? paymentStatus;
  Future<void> confirmPayment() async {
    try {
      paymentStatus = AsyncValue.loading();
      notifyListeners();
      UserPass confirmedPass = UserPass(
        id: Uuid().v4(),
        startDate: DateTime.now(),
        expirationDate: DateTime.now().add(selectedSubs.validDuration),
        passSubscriptionId: selectedSubs.id,
        userId: userState.user!.id,
      );
      await userState.updateUserPass(confirmedPass);
      paymentStatus = AsyncValue.success(true);
    } catch (err) {
      paymentStatus = AsyncValue.error(err);
    } finally {
      notifyListeners();
    }
  }

  String get buttonLabel {
    final state = paymentStatus?.state;
    if (state == AsyncValueState.loading) return "Processing";
    if (state == AsyncValueState.success) return "Processing Complete";
    return "Pay \$${selectedSubs.price.toStringAsFixed(2)}";
  }
}
