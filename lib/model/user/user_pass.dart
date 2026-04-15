enum PassStatus { active, inactive }

class UserPass {
  final String id;
  final String userId;
  final String passSubscriptionId;
  final DateTime startDate;
  final DateTime expirationDate;

  const UserPass({
    required this.id,
    required this.startDate,
    required this.expirationDate,
    required this.passSubscriptionId,
    required this.userId,
  });

  PassStatus get passStatus => DateTime.now().isBefore(expirationDate)
      ? PassStatus.active
      : PassStatus.inactive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPass &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          passSubscriptionId == other.passSubscriptionId &&
          startDate == other.startDate &&
          expirationDate == other.expirationDate &&
          passStatus == other.passStatus;

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    passSubscriptionId,
    startDate,
    expirationDate,
    passStatus,
  );

  @override
  String toString() {
    return 'UserPass(id: $id, userId: $userId, subscriptionId: $passSubscriptionId, start: $startDate, expires: $expirationDate)';
  }
}
