import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/domain/usecases/sign_in_user.dart';
import 'package:iiko_delivery/feature/presentation/bloc/sign_in_cubit/sign_in_state.dart';

class SignInUserCubit extends Cubit<SignInUserState> {
  final SignInUser signInUser;

  SignInUserCubit({required this.signInUser}) : super(SignInUserInitial());

  auth(String email, String password) async {
    emit(SignInUserStart());

    final failureOrUser = await signInUser(UserSignInParams(email: email, password: password));
    emit(failureOrUser.fold(
        (failure) => SignInUserError(message: mapFailureFromMessage(failure)),
        (auth) => SignInUserLoaded(user: auth)));
  }

  String mapFailureFromMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return "ServerFailure";
      default:
        return "Unexpected error";
    }
  }
}