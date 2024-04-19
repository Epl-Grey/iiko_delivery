import 'package:dartz/dartz.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserRepository {
  Future<Either<Failure, AuthResponse>> signIn(String email, String password);
  Future<Either<Failure, void>> signOut();
}
