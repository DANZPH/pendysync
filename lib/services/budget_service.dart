import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/budget_model.dart';

class BudgetService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Create Budget
  Future<void> addBudget(Budget budget) async {
    await supabase.from('budgets').insert({
      'user_id': budget.userId,
      'category': budget.category,
      'limit_amount': budget.limitAmount,
      'created_at': budget.createdAt.toIso8601String(),
    });
  }

  // Get User Budgets
  Future<List<Budget>> getUserBudgets(String userId) async {
    final response =
        await supabase.from('budgets').select().eq('user_id', userId);
    return response.map((e) => Budget.fromJson(e)).toList();
  }

  // Update Budget
  Future<void> updateBudget(Budget budget) async {
    await supabase.from('budgets').update({
      'category': budget.category,
      'limit_amount': budget.limitAmount,
    }).eq('id', budget.id);
  }

  // Delete Budget
  Future<void> deleteBudget(String budgetId) async {
    await supabase.from('budgets').delete().eq('id', budgetId);
  }
}
