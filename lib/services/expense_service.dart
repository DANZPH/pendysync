]import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/expense_model.dart';

class ExpenseService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Create Expense
  Future<void> addExpense(Expense expense) async {
    await supabase.from('expenses').insert({
      'user_id': expense.userId,
      'category': expense.category,
      'amount': expense.amount,
      'date': expense.date.toIso8601String(),
    });
  }

  // Get User Expenses
  Future<List<Expense>> getUserExpenses(String userId) async {
    final response =
        await supabase.from('expenses').select().eq('user_id', userId);

    return response.map((e) => Expense.fromJson(e)).toList();
  }

  // Update Expense
  Future<void> updateExpense(Expense expense) async {
    await supabase.from('expenses').update({
      'category': expense.category,
      'amount': expense.amount,
      'date': expense.date.toIso8601String(),
    }).eq('id', expense.id);
  }

  // Delete Expense
  Future<void> deleteExpense(String expenseId) async {
    await supabase.from('expenses').delete().eq('id', expenseId);
  }
}
