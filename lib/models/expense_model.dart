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

  // Convert JSON to Expense object
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
    );
  }

  // Convert Expense object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }
}
