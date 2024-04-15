import 'package:equatable/equatable.dart';

abstract class SignOutUserState extends Equatable {
  const SignOutUserState();

  @override
  List<Object?> get props => [];
}

class SignOutUserInitial extends SignOutUserState {}

class SignOutUserStart extends SignOutUserState {}

class SignOutUserLoaded extends SignOutUserState {
  const SignOutUserLoaded();
}

class SignOutUserError extends SignOutUserState {
  final String message;

  const SignOutUserError({required this.message});

  @override
  List<Object?> get props => [message];
}