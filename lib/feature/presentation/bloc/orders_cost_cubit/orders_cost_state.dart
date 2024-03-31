part of 'orders_cost_cubit.dart';

sealed class OrdersCostState extends Equatable {
  const OrdersCostState();

  @override
  List<Object> get props => [];
}

final class OrdersCostInitial extends OrdersCostState {}

final class OrdersCostLoading extends OrdersCostState {}

final class OrdersCostSuccess extends OrdersCostState {
  final Map<int, Decimal> costs;

  const OrdersCostSuccess({required this.costs});

  @override
  get props => [costs];
}

final class OrdersCostFailure extends OrdersCostState {
  final String message;

  const OrdersCostFailure({required this.message});

  @override
  get props => [message];
}
