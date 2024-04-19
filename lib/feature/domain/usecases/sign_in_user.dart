import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/core/usecases/usecase.dart';

import 'package:beFit_Del/feature/domain/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInUser extends UseCase<AuthResponse, UserSignInParams>{
final UserRepository userRepository;

  SignInUser({required this.userRepository});

  @override
  Future<Either<Failure, AuthResponse>> call(UserSignInParams params) async {
    final response = await userRepository.signIn(params.email, params.password);
    return response;
  }
}

class UserSignInParams extends Equatable {
  final String email;
  final String password;

  const UserSignInParams({required this.email, required this.password});
  
  @override
  List<Object?> get props => [email, password];

  
}