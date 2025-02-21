import 'package:flutter/material.dart';
import 'package:spendysync/models/user_model.dart';

class ExpensesPage extends StatelessWidget {
  final UserModel user;

  const ExpensesPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expenses")),
      body: Center(child: Text("Expense Tracking Page")),
    );
  }
}
