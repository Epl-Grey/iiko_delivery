import 'dart:core';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/core/usecases/usecase.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/domain/repositories/order_repository.dart';

class GetUserOrdersByDay extends UseCase<List<OrderEntity>, OrdersByDayParams> {
  final OrderRepository orderRepository;

  GetUserOrdersByDay({required this.orderRepository});

  @override
  Future<Either<Failure, List<OrderEntity>>> call(OrdersByDayParams params) async{
    final startDate = DateTime.utc(
      params.year,
      params.month,
      params.day
    );

    final endDate = DateTime.utc(
      params.year,
      params.month,
      params.day + 1
    );

    final response = await orderRepository.getUserOrdersByDateRange(startDate, endDate, isDelivered: params.isDelivered);
    return response;
  }
}

class OrdersByDayParams extends Equatable{
  final int year;
  final int month;
  final int day;
  final bool? isDelivered;

  const OrdersByDayParams({
    required this.year,
    required this.month,
    required this.day,
    required this.isDelivered,
  });

  @override
  get props => [year, month, day, isDelivered];
}