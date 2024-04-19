import 'package:dartz/dartz.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/feature/domain/repositories/user_repository.dart';

class SignOutUser {
final UserRepository userRepository;

  SignOutUser({required this.userRepository});

  Future<Either<Failure, void>> call() async {
    final response = await userRepository.signOut();
    return response;
  }
}
