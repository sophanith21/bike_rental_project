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
}
