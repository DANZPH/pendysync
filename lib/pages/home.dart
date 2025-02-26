import 'package:flutter/material.dart';
import 'package:spendysync/models/user_model.dart';
import 'package:spendysync/services/expense_service.dart';
import 'package:spendysync/services/budget_service.dart';
import 'package:spendysync/models/expense_model.dart';
import 'package:spendysync/models/budget_model.dart';
import 'package:spendysync/widgets/sidebar.dart';

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

  void _showAddExpenseDialog() {
    TextEditingController categoryController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Amount"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String category = categoryController.text;
                double amount = double.tryParse(amountController.text) ?? 0.0;

                if (category.isNotEmpty && amount > 0) {
                  Expense newExpense = Expense(
                    id: '',
                    userId: widget.user.userId,
                    category: category,
                    amount: amount,
                    date: DateTime.now(),
                  );
                  await _expenseService.addExpense(newExpense);
                  _loadData();
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showAddBudgetDialog() {
    TextEditingController categoryController = TextEditingController();
    TextEditingController limitController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Budget"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
              ),
              TextField(
                controller: limitController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Limit Amount"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String category = categoryController.text;
                double limitAmount =
                    double.tryParse(limitController.text) ?? 0.0;

                if (category.isNotEmpty && limitAmount > 0) {
                  Budget newBudget = Budget(
                    id: '',
                    userId: widget.user.userId,
                    category: category,
                    limitAmount: limitAmount,
                    createdAt: DateTime.now(),
                  );
                  await _budgetService.addBudget(newBudget);
                  _loadData();
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome, ${widget.user.name}!")),
      drawer: Sidebar(user: widget.user),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Recent Expenses",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.money),
                    title: Text(expenses[index].category),
                    subtitle:
                        Text("₱${expenses[index].amount.toStringAsFixed(2)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _expenseService.deleteExpense(expenses[index].id);
                        _loadData();
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showAddExpenseDialog,
              child: const Text("Add Expense"),
            ),
            const SizedBox(height: 20),
            const Text("Budgets",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: budgets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.pie_chart),
                    title: Text(budgets[index].category),
                    subtitle: Text(
                        "Limit: ₱${budgets[index].limitAmount.toStringAsFixed(2)}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _budgetService.deleteBudget(budgets[index].id);
                        _loadData();
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showAddBudgetDialog,
              child: const Text("Add Budget"),
            ),
          ],
        ),
      ),
    );
  }
}
