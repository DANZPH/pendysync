import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:spendysync/models/user_model.dart';
import 'package:spendysync/pages/home.dart';
import 'package:spendysync/styles/styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _supabase = Supabase.instance.client;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!formKey.currentState!.validate()) return;
    setState(() => isLoading = true);

    try {
      final authResponse = await _supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (authResponse.user == null) throw Exception("Login failed");

      // Fetch user details from 'users' table
      final userData = await _supabase
          .from('users')
          .select()
          .eq('auth_id', authResponse.user!.id)
          .single();

      final user = UserModel.fromMap(userData);

      if (!mounted) return; // Prevents context issues in async
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Home(user: user),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(50),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.asset('assets/images/login.jpg'),
                ),
                const Text("Welcome Back!",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: Styles.customInputDecoration('Email'),
                  validator: (value) =>
                      value!.isEmpty ? 'Email is required' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: obscureText,
                  decoration: Styles.customInputDecoration(
                    'Password',
                    suffixIcon:
                        obscureText ? Icons.visibility_off : Icons.visibility,
                    suffixIconOnPress: () =>
                        setState(() => obscureText = !obscureText),
                  ),
                  validator: (value) => value!.length < 8
                      ? 'Password must be 8+ characters'
                      : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _login,
                    style: Styles.primaryButton(),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navigate to Register page (assuming it exists)
                  },
                  child: const Text('Don\'t have an account? Sign up',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
