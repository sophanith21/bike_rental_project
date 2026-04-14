enum PassStatus { active, inactive }

class UserPass {
  final String id;
  final String userId;
  final String passSubscriptionId;
  final DateTime startDate;
  final DateTime expirationDate;
  final PassStatus passStatus;

  const UserPass({
    required this.id,
    required this.startDate,
    required this.expirationDate,
    required this.passStatus,
    required this.passSubscriptionId,
    required this.userId,
  });

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
}
