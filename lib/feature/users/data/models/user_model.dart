import 'package:iiko_delivery/feature/users/domain/entities/user_entitiy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// class UserModel extends UserEntity {
//   const UserModel({
//     required super.mail,
//     required super.password,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> map) {
//     return UserModel(
//       mail: map['mail'] as String,
//       password: map['password'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'mail': mail,
//       'password': password,
//     };
//   }
// }

class UserModel extends UserEntity {
  const UserModel({
    required super.authResponse,

  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      authResponse: map['mail'] as AuthResponse,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authResponse': authResponse,
    };
  }
}

