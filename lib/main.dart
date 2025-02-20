import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:spendysync/pages/auth/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:
        'https://qduvtjtafxbuqkkvtqen.supabase.co', // Replace with your Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFkdXZ0anRhZnhidXFra3Z0cWVuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyMzMzMTYsImV4cCI6MjA1NDgwOTMxNn0.TNly2va6MUIbyP_MB0uX8DHGyDh3si-4l4OBbWVGrmU', // Replace with your Supabase anon key
  );

  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Welcome(),
    );
  }
}
