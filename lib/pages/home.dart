import 'package:flutter/material.dart';
import 'package:spendysync/models/user_model.dart';
import 'package:spendysync/services/expense_service.dart';
import 'package:spendysync/services/budget_service.dart';
import 'package:spendysync/models/expense_model.dart';
import 'package:spendysync/models/budget_model.dart';
import 'add_expense.dart';
import 'add_budget.dart';

class Home extends StatefulWidget {
  final UserModel user;

  const Home({super.key, required this.user});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ExpenseService _expenseService = ExpenseService();
  final BudgetService _budgetService = BudgetService();

  List<Expense> expenses = [];
  List<Budget> budgets = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final fetchedExpenses =
        await _expenseService.getUserExpenses(widget.user.userId);
    final fetchedBudgets =
        await _budgetService.getUserBudgets(widget.user.userId);
    setState(() {
      expenses = fetchedExpenses;
      budgets = fetchedBudgets;
    });
  }

  // Delete Expense
  void _deleteExpense(String id) async {
    await _expenseService.deleteExpense(id);
    _loadData();
  }

  // Delete Budget
  void _deleteBudget(String id) async {
    await _budgetService.deleteBudget(id);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome, ${widget.user.name}!")),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "addExpense",
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddExpense(user: widget.user)),
              );
              _loadData();
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "addBudget",
            backgroundColor: Colors.green,
            child: Icon(Icons.attach_money),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddBudget(user: widget.user)),
              );
              _loadData();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recent Expenses",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(expenses[index].category),
                    subtitle:
                        Text("₱${expenses[index].amount.toStringAsFixed(2)}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteExpense(expenses[index].id),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text("Budgets",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: budgets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(budgets[index].category),
                    subtitle: Text(
                        "Limit: ₱${budgets[index].limitAmount.toStringAsFixed(2)}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteBudget(budgets[index].id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
