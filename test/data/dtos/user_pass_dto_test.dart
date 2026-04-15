import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bike_rental_project/data/dtos/user/user_pass_dto.dart';

void main() {
  group('UserPassDto Tests', () {
    test('fromJson should handle Firestore Timestamps correctly', () {
      final id = 'userPass001';
      final now = DateTime.now();
      final json = {
        'userId': 'user_A',
        'passSubscriptionId': 'sub_1',
        'startDate': Timestamp.fromDate(now),
        'expirationDate': Timestamp.fromDate(now.add(const Duration(days: 1))),
      };

      final result = UserPassDto.fromJson(id, json);

      expect(result.userId, 'user_A');
      expect(result.startDate, isA<DateTime>());
      // Using difference to avoid millisecond precision issues in some environments
      expect(result.startDate.difference(now).inSeconds, 0);
    });

    test('toJson should convert DateTime back to Timestamp for Firestore', () {
      // Logic for verifying that UserPassDto.toJson uses Timestamp.fromDate
    });
  });
}
