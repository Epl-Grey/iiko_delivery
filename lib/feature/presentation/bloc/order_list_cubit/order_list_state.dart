import 'package:equatable/equatable.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderEmpty extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderLoading extends OrderState {
  final List<OrderEntity> oldOrdersList;
  final bool isFirstFetch;

  const OrderLoading(
    this.oldOrdersList, {
    this.isFirstFetch = false,
  });

  @override
  List<Object?> get props => [oldOrdersList];
}

class OrderLoaded extends OrderState {
  final List<OrderEntity> ordersList;

  const OrderLoaded({required this.ordersList});

  @override
  List<Object?> get props => [ordersList];
}

class OrderError extends OrderState {
  final String message;

  const OrderError({required this.message});

  @override
  List<Object?> get props => [mapFailureFromMessage];
}

String mapFailureFromMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "ServerFailure";
    default:
      return "Unexpected error";
  }
}
