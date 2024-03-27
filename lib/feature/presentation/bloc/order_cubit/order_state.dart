
import 'package:equatable/equatable.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoadingState extends OrderState{}


class GetUserOrdersSuccessState extends OrderState {
  final List<OrderEntity> orders;
  
  const GetUserOrdersSuccessState({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];
}

class GetUserOrdersFailState extends OrderState {
  final String message;
  
  const GetUserOrdersFailState({
    required this.message
  });

  @override
  List<Object> get props => [message];
}
