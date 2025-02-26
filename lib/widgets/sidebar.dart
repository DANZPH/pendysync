import 'package:flutter/material.dart';
import 'package:spendysync/models/user_model.dart';
import 'package:spendysync/pages/auth/login.dart';
import 'package:spendysync/services/auth_service.dart';

class Sidebar extends StatelessWidget {
  final UserModel user;

  const Sidebar({super.key, required this.user});

  void _logout(BuildContext context) async {
    await AuthService().logout(); // Call logout function
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name ?? "User"),
            accountEmail: Text(user.email),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.black),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text("Expenses"),
            onTap: () {
              // Navigate to expenses page if needed
            },
          ),
          ListTile(
            leading: const Icon(Icons.pie_chart),
            title: const Text("Budgets"),
            onTap: () {
              // Navigate to budgets page if needed
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () => _logout(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
