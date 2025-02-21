import 'package:flutter/material.dart';
import 'package:spendysync/models/user_model.dart';

class SettingsPage extends StatelessWidget {
  final UserModel user;

  const SettingsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(child: Text("Settings Page")),
    );
  }
}
