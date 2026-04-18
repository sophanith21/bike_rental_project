enum PassStatus { active, inactive }

class UserPass {
  final String id;
  final String userId;
  final String passSubscriptionId;
  final String passName;
  final DateTime startDate;
  final DateTime expirationDate;

  const UserPass({
    required this.id,
    required this.startDate,
    required this.expirationDate,
    required this.passSubscriptionId,
    required this.userId,
    required this.passName,
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
          passName == other.passName &&
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
    passName,
    expirationDate,
    passStatus,
  );

  @override
  String toString() {
    return 'UserPass(id: $id, passName: $passName, userId: $userId, subscriptionId: $passSubscriptionId, start: $startDate, expires: $expirationDate)';
  }
}
