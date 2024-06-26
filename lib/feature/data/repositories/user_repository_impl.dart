import 'package:dartz/dartz.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/feature/data/datasources/user_remote_data_source.dart';
import 'package:beFit_Del/feature/domain/repositories/user_repository.dart';
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
    } catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> signOut() async{
    try {
          final respone = await userRemoteDataSources.signOutUser();
    return Right(respone);
    } on ServerFailure catch(error) {
      return Left(ServerFailure(message: error.message));
    } catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }
}

