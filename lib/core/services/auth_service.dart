import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<User> register(String email, String password) async {
    final res = await _client.auth.signUp(email: email, password: password);

    if (res.user == null) {
      throw AuthException('Registration failed. Please try again.');
    }
    return res.user!;
  }

  Future<User> login(String email, String password) async {
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (res.user == null) {
      throw AuthException('Login failed. Please check your credentials.');
    }
    return res.user!;
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}
