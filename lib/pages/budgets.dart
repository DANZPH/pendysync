import 'package:flutter/material.dart';
import 'package:spendysync/models/user_model.dart';

class BudgetsPage extends StatelessWidget {
  final UserModel user;

  const BudgetsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Budgets")),
      body: Center(child: Text("Budget Management Page")),
    );
  }
}
