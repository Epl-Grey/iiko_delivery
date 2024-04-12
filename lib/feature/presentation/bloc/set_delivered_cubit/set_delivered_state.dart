import 'package:equatable/equatable.dart';


abstract class SetDeliveredState extends Equatable {
  const SetDeliveredState();

  @override
  List<Object?> get props => [];
}

class SetDeliveredInitial extends SetDeliveredState {}

class SetDeliveredStart extends SetDeliveredState {}

class SetDeliveredLoaded extends SetDeliveredState {

}

class SetDeliveredError extends SetDeliveredState {
  final String message;

  const SetDeliveredError({required this.message});

  @override
  List<Object?> get props => [message];
}