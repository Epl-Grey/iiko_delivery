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
  final Map<int, Decimal> costsForRecent;
  const OrdersCostSuccess({required this.costs, required this.costsForRecent});

  @override
  get props => [costs, costsForRecent];
}

final class OrdersCostFailure extends OrdersCostState {
  final String message;

  const OrdersCostFailure({required this.message});

  @override
  get props => [message];
}
