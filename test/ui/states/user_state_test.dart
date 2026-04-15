import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bike_rental_project/ui/states/user_state.dart';
import 'package:bike_rental_project/model/user/user.dart';
import 'package:bike_rental_project/model/user/user_pass.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockUserRepository mockUserRepo;
  late MockUserPassRepository mockPassRepo;

  setUp(() {
    mockUserRepo = MockUserRepository();
    mockPassRepo = MockUserPassRepository();
  });

  test(
    'UserState should fetch Allya on init and clear pass when expired',
    () async {
      final mockUser = User(id: 'u1', name: 'Allya');
      // Set expiration to 100ms from now
      final expiry = DateTime.now().add(const Duration(milliseconds: 100));
      final mockPass = UserPass(
        id: 'p1',
        userId: 'u1',
        expirationDate: expiry,
        startDate: DateTime.now(),
        passSubscriptionId: 's1',
      );

      when(
        () => mockUserRepo.getUser("Allya", ""),
      ).thenAnswer((_) async => mockUser);
      when(
        () => mockPassRepo.getActiveUserPass('u1'),
      ).thenAnswer((_) => Stream.value(mockPass));

      final userState = UserState(
        userRepository: mockUserRepo,
        userPassRepository: mockPassRepo,
      );

      // Wait for the async init to finish and the stream to emit
      await Future.delayed(Duration.zero);
      expect(userState.userPass, isNotNull);

      // Wait for the 100ms timer inside UserState to fire
      await Future.delayed(const Duration(milliseconds: 150));
      expect(userState.userPass, isNull);
    },
  );
}
