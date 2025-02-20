import 'package:flutter/material.dart';
import 'package:spendysync/models/budget_model.dart';
import 'package:spendysync/services/budget_service.dart';
import 'package:spendysync/models/user_model.dart';

class AddBudget extends StatefulWidget {
  final UserModel user;
  const AddBudget({super.key, required this.user});

  @override
  _AddBudgetState createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  final BudgetService _budgetService = BudgetService();
  final _formKey = GlobalKey<FormState>();
  String category = "";
  double limitAmount = 0.0;

  void _submitBudget() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Budget newBudget = Budget(
        id: "", // Auto-generated by Supabase
        userId: widget.user.userId,
        category: category,
        limitAmount: limitAmount,
        createdAt: DateTime.now(),
      );

      await _budgetService.addBudget(newBudget);
      Navigator.pop(context); // Close form after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Budget")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Category"),
                onSaved: (value) => category = value!,
                validator: (value) =>
                    value!.isEmpty ? "Please enter a category" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Budget Limit"),
                keyboardType: TextInputType.number,
                onSaved: (value) => limitAmount = double.parse(value!),
                validator: (value) =>
                    value!.isEmpty ? "Please enter an amount" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitBudget,
                child: Text("Save Budget"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
