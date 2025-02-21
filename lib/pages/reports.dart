import 'package:flutter/material.dart';
import 'package:spendysync/models/user_model.dart';

class ReportsPage extends StatelessWidget {
  final UserModel user;

  const ReportsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reports")),
      body: Center(child: Text("Financial Reports Page")),
    );
  }
}
