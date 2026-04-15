import 'package:bike_rental_project/model/user/user.dart';
import 'package:bike_rental_project/ui/screens/payment/view_model/payment_view_model.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bike_rental_project/model/booking/pass_subscription.dart';
import '../../helpers/mocks.dart';

void main() {
  setUpAll(() => registerTestFallbacks());
  test(
    'PaymentViewModel should update UserState on successful payment',
    () async {
      final mockUserState = MockUserState();
      final sub = PassSubscription(
        id: 's1',
        title: 'Daily',
        price: 2.0,
        coreBenefits: [],
        validDuration: const Duration(days: 1),
      );

      when(() => mockUserState.user).thenReturn(User(id: 'u1', name: 'Allya'));
      when(
        () => mockUserState.updateUserPass(any()),
      ).thenAnswer((_) async => {});

      final vm = PaymentViewModel(selectedSubs: sub, userState: mockUserState);

      await vm.confirmPayment();

      expect(vm.paymentStatus?.state, AsyncValueState.success);
      verify(() => mockUserState.updateUserPass(any())).called(1);
      expect(vm.buttonLabel, "Processing Complete");
    },
  );
}
