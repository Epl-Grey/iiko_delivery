import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/users/domain/usecases/sign_in_user.dart';
import 'package:iiko_delivery/feature/users/presentation/bloc/sign_in_state.dart';

class SignInUserCubit extends Cubit<SignInUserState> {
  final SignInUser signInUser;

  SignInUserCubit({required this.signInUser}) : super(SignInUserEmpty());

  auth(String email, String password) async {
    emit(SignInUserStart());

    final failureOrUser = await signInUser(UserSignInParams(email: email, password: password));
    emit(failureOrUser.fold(
        (failure) => SignInUserError(message: mapFailureFromMessage(failure)),
        (auth) => SignInUserLoaded(user: auth)));
  }

  String mapFailureFromMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailure";
      default:
        return "Unexpected error";
    }
  }
}