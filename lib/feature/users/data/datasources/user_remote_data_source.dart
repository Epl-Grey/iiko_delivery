import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserRemoteDataSources {
  Future<AuthResponse> signInUser(String email, String password);
}

class UserRemoteDataSourcesImpl extends UserRemoteDataSources {
  final SupabaseClient supabaseClient;

  UserRemoteDataSourcesImpl({required this.supabaseClient});

  @override
  Future<AuthResponse> signInUser(String email, String password) async {
    return await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
}

