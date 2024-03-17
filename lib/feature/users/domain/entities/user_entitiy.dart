import 'package:supabase_flutter/supabase_flutter.dart';

// class UserEntity extends Equatable {
//   final String mail;
//   final String password;

//   const UserEntity({required this.mail, required this.password});

//   @override

//   List<Object?> get props => [mail, password];

// }

class UserEntity {
  final AuthResponse authResponse;

  const UserEntity({
    required this.authResponse,
  });
}
