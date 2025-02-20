import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:spendysync/pages/auth/login.dart';
import 'package:spendysync/styles/styles.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  Future<void> signUp() async {
    final supabase = Supabase.instance.client;

    if (!formKey.currentState!.validate()) return;

    try {
      final authResponse = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );

      final userId = authResponse.user?.id;
      if (userId != null) {
        await supabase.from('users').insert({
          'auth_id': userId,
          'email': emailController.text,
          'name': nameController.text,
        });

        // Navigate to Login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    } catch (e) {
      print("Sign-up error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/signin.jpg', height: 200),
                  const SizedBox(height: 20),
                  const Text("Sign Up Now!",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    decoration: Styles.customInputDecoration('Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Name is required' : null,
                  ),
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
                      suffixIcon: obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      suffixIconOnPress: () {
                        setState(() => obscureText = !obscureText);
                      },
                    ),
                    validator: (value) => value!.length < 8
                        ? 'Password must be at least 8 characters'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: signUp,
                    style: Styles.primaryButton(),
                    child: const Text('Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login())),
                    child: const Text('Already have an account? Login',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
