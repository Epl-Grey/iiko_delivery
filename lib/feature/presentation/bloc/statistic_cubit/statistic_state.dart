
import 'package:equatable/equatable.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';

abstract class StatisticState extends Equatable {
  const StatisticState();

  @override
  List<Object> get props => [];
}

class StatisticInitial extends StatisticState {}

class StatisticLoadingState extends StatisticState{}


class GetUserStatisticsSuccessState extends StatisticState {
  final List<OrderEntity> orders;
  
  const GetUserStatisticsSuccessState({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];
}

class GetUserStatisticsFailState extends StatisticState {
  final String message;
  
  const GetUserStatisticsFailState({
    required this.message
  });

  @override
  List<Object> get props => [message];
}
