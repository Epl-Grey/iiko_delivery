
import 'package:equatable/equatable.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';

abstract class DailyOrderState extends Equatable {
  const DailyOrderState();

  @override
  List<Object> get props => [];
}

class DailyOrderInitial extends DailyOrderState {}

class DailyOrderLoadingState extends DailyOrderState{}


class GetUserDailyOrdersSuccessState extends DailyOrderState {
  final List<OrderEntity> orders;
  
  const GetUserDailyOrdersSuccessState({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];
}

class GetUserDailyOrdersFailState extends DailyOrderState {
  final String message;
  
  const GetUserDailyOrdersFailState({
    required this.message
  });

  @override
  List<Object> get props => [message];
}
