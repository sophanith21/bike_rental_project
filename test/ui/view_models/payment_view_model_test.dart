import 'dart:async';
import 'package:bike_rental_project/model/booking/benefit.dart';
import 'package:bike_rental_project/model/booking/pass_subscription.dart';
import 'package:bike_rental_project/model/user/user.dart';
import 'package:bike_rental_project/ui/screens/payment/view_model/payment_view_model.dart';
import 'package:bike_rental_project/utils/async_value.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mocktail/mocktail.dart';
import '../../helpers/mocks.dart';

void main() {
  setUpAll(() => registerTestFallbacks());

  group('PaymentViewModel - buttonLabel Logic', () {
    test(
      'confirmPayment should set status to success and show completion label',
      () async {
        final mockUserState = MockUserState();
        final selectedSub = PassSubscription(
          id: 's1',
          title: 'T',
          validDuration: const Duration(days: 1),
          price: 0.2,
          coreBenefits: [
            Benefit(iconData: Symbols.clock_arrow_down, label: "Test"),
          ],
        );

        when(() => mockUserState.user).thenReturn(User(id: 'u1', name: 'A'));
        when(
          () => mockUserState.updateUserPass(any()),
        ).thenAnswer((_) async => {});

        final vm = PaymentViewModel(
          selectedSubs: selectedSub,
          userState: mockUserState,
        );

        await vm.confirmPayment();

        expect(vm.paymentStatus?.state, AsyncValueState.success);
        // MATCHED: Based on your getter: if (state == AsyncValueState.success) return "Processing Complete";
        expect(vm.buttonLabel, "Processing Complete");
        verify(() => mockUserState.updateUserPass(any())).called(1);
      },
    );

    test('buttonLabel should show price on initial state and error state', () {
      final vm = PaymentViewModel(
        selectedSubs: PassSubscription(
          id: '1',
          price: 0.2,
          title: 'T',
          validDuration: const Duration(days: 1),
          coreBenefits: [],
        ),
        userState: MockUserState(),
      );

      // MATCHED: "Pay \$${selectedSubs.price.toStringAsFixed(2)}"
      expect(vm.buttonLabel, "Pay \$0.20");

      vm.paymentStatus = AsyncValue.error("Failed");
      // MATCHED: Error state falls through to the default price label
      expect(vm.buttonLabel, "Pay \$0.20");
    });

    test('confirmPayment should transition through "Processing"', () async {
      final mockUserState = MockUserState();
      final completer = Completer<void>();
      final selectedSub = PassSubscription(
        id: 's1',
        title: 'T',
        validDuration: const Duration(days: 1),
        price: 0.2,
        coreBenefits: [],
      );

      when(() => mockUserState.user).thenReturn(User(id: 'u1', name: 'A'));
      when(
        () => mockUserState.updateUserPass(any()),
      ).thenAnswer((_) => completer.future);

      final vm = PaymentViewModel(
        selectedSubs: selectedSub,
        userState: mockUserState,
      );

      final future = vm.confirmPayment();

      // Check state mid-flight
      expect(vm.paymentStatus?.state, AsyncValueState.loading);
      // MATCHED: if (state == AsyncValueState.loading) return "Processing";
      expect(vm.buttonLabel, "Processing");

      completer.complete();
      await future;

      expect(vm.buttonLabel, "Processing Complete");
    });

    test(
      'confirmPayment should stay on price label when update fails',
      () async {
        final mockUserState = MockUserState();
        final selectedSub = PassSubscription(
          id: 's1',
          title: 'T',
          validDuration: const Duration(days: 1),
          price: 0.5,
          coreBenefits: [],
        );

        when(() => mockUserState.user).thenReturn(User(id: 'u1', name: 'A'));
        when(
          () => mockUserState.updateUserPass(any()),
        ).thenThrow(Exception("Failed"));

        final vm = PaymentViewModel(
          selectedSubs: selectedSub,
          userState: mockUserState,
        );

        await vm.confirmPayment();

        expect(vm.paymentStatus?.state, AsyncValueState.error);

        expect(vm.buttonLabel, "Pay \$0.50");
      },
    );
  });
}
