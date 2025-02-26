import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
