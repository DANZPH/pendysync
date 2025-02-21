import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:spendysync/pages/auth/welcome.dart';
import 'package:spendysync/pages/home.dart';
import 'package:spendysync/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:
        'https://qduvtjtafxbuqkkvtqen.supabase.co', // Replace with your Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFkdXZ0anRhZnhidXFra3Z0cWVuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyMzMzMTYsImV4cCI6MjA1NDgwOTMxNn0.TNly2va6MUIbyP_MB0uX8DHGyDh3si-4l4OBbWVGrmU', // Replace with your Supabase anon key
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final session = Supabase.instance.client.auth.currentSession;

    if (session?.user != null) {
      final userData = await _fetchUser(session!.user.id);
      if (userData != null) {
        setState(() {
          currentUser = userData;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<UserModel?> _fetchUser(String userId) async {
    final response = await Supabase.instance.client
        .from('users')
        .select()
        .eq('auth_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return UserModel.fromMap(response);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spendysync',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (currentUser != null ? Home(user: currentUser!) : const Welcome()),
    );
  }
}
