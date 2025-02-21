import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:spendysync/models/user_model.dart';
import 'package:spendysync/pages/home.dart';
import 'package:spendysync/pages/expenses.dart';
import 'package:spendysync/pages/budgets.dart';
import 'package:spendysync/pages/reports.dart';
import 'package:spendysync/pages/settings.dart';
import 'package:spendysync/pages/auth/welcome.dart';

class Sidebar extends StatelessWidget {
  final UserModel user;

  const Sidebar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : "?",
                style: TextStyle(fontSize: 24.0, color: Colors.blue),
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, "Home", () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Home(user: user)));
          }),
          _buildDrawerItem(Icons.attach_money, "Expenses", () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => ExpensesPage(user: user)));
          }),
          _buildDrawerItem(Icons.account_balance_wallet, "Budgets", () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => BudgetsPage(user: user)));
          }),
          _buildDrawerItem(Icons.bar_chart, "Reports", () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => ReportsPage(user: user)));
          }),
          _buildDrawerItem(Icons.settings, "Settings", () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => SettingsPage(user: user)));
          }),
          Divider(),
          _buildDrawerItem(Icons.exit_to_app, "Logout", () async {
            await _logout(context);
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontSize: 16.0)),
      onTap: onTap,
    );
  }

  Future<void> _logout(BuildContext context) async {
    final supabase = Supabase.instance.client;

    await supabase.auth.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Welcome()),
      (route) => false,
    );
  }
}
