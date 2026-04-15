import 'package:bike_rental_project/data/dtos/booking/pass_subscription_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PassSubscriptionDto Tests', () {
    test('fromJson should parse valid Firestore data and convert duration', () {
      final id = 'passSub123';
      final json = {
        'title': "Daily Explorer",
        'price': 2.0,
        'coreBenefits': [
          {'iconData': "clock", 'label': "Valid for 24 hours"},
        ],
        'validDurationSeconds': 86400, // 24 hours
      };

      final result = PassSubscriptionDto.fromJson(id, json);

      expect(result.id, id);
      expect(result.title, "Daily Explorer");
      expect(result.price, 2.0);
      expect(result.validDuration.inHours, 24);
      expect(result.coreBenefits.first.label, "Valid for 24 hours");
    });

    test('fromJson should throw AssertionError if price is not a number', () {
      expect(
        () => PassSubscriptionDto.fromJson('id', {
          'title': "Test",
          'price': "wrong_type",
          'coreBenefits': [],
          'validDurationSeconds': 100,
        }),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
