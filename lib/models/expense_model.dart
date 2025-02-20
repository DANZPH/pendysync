class Expense {
  final String id;
  final String userId;
  final String category;
  final double amount;
  final DateTime date;

  Expense({
    required this.id,
    required this.userId,
    required this.category,
    required this.amount,
    required this.date,
  });

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      userId: map['user_id'],
      category: map['category'],
      amount: map['amount'].toDouble(),
      date: DateTime.parse(map['date']),
    );
  }
}
