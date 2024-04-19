import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/feature/domain/usecases/sign_out_user.dart';
import 'package:beFit_Del/feature/presentation/bloc/sign_out_cubit/sign_out_state.dart';

class SignOutUserCubit extends Cubit<SignOutUserState> {
  final SignOutUser signOutUser;

  SignOutUserCubit({required this.signOutUser}) : super(SignOutUserInitial());

  auth() async {
    emit(SignOutUserStart());

    final failureOrUser = await signOutUser();
    emit(failureOrUser.fold(
        (failure) => SignOutUserError(message: mapFailureFromMessage(failure)),
        (signOut) => const SignOutUserLoaded()));
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