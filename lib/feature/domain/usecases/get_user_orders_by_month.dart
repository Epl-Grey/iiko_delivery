import 'dart:core';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/core/usecases/usecase.dart';
import 'package:beFit_Del/feature/domain/entities/order_entity.dart';
import 'package:beFit_Del/feature/domain/repositories/order_repository.dart';

class GetUserOrdersByMonth extends UseCase<List<OrderEntity>, OrdersByMonthParams> {
  final OrderRepository orderRepository;

  GetUserOrdersByMonth({required this.orderRepository});

  @override
  Future<Either<Failure, List<OrderEntity>>> call(OrdersByMonthParams params) async{
    final startDate = DateTime.utc(
      params.year,
      params.month,
    );

    final endDate = DateTime.utc(
      params.year,
      params.month + 1,
    );

    final response = await orderRepository.getUserOrdersByDateRange(startDate, endDate, isDelivered: params.isDelivered);
    return response;
  }
  
}

class OrdersByMonthParams extends Equatable{
  final int year;
  final int month;
  final bool? isDelivered;

  const OrdersByMonthParams({
    required this.year,
    required this.month,
    this.isDelivered,
  });

  @override
  get props => [year, month, isDelivered];
}