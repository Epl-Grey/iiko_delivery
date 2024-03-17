import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SignInUserState extends Equatable {
  const SignInUserState();

  @override
  List<Object?> get props => [];
}

class SignInUserEmpty extends SignInUserState {}

class SignInUserStart extends SignInUserState {}

class SignInUserLoaded extends SignInUserState {
  final AuthResponse user;

  const SignInUserLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignInUserError extends SignInUserState {
  final String message;

  const SignInUserError({required this.message});

  @override
  List<Object?> get props => [message];
}