import 'package:dartz/dartz.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/users/data/datasources/user_remote_data_source.dart';
import 'package:iiko_delivery/feature/users/domain/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSources userRemoteDataSources;

  UserRepositoryImpl({
    required this.userRemoteDataSources,
  });

  @override
  Future<Either<Failure, AuthResponse>> signIn(String email, String password) async{
    try {
          final respone = await userRemoteDataSources.signInUser(email, password);
    return Right(respone);
    } on ServerFailure catch(error) {
      return Left(ServerFailure(message: error.message));
    }
  }


}

