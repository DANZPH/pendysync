class Budget {
  final String id;
  final String userId;
  final String category;
  final double limitAmount;
  final DateTime createdAt;

  Budget({
    required this.id,
    required this.userId,
    required this.category,
    required this.limitAmount,
    required this.createdAt,
  });

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      userId: map['user_id'],
      category: map['category'],
      limitAmount: map['limit_amount'].toDouble(),
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
