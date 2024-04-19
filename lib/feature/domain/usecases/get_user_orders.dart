import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/core/usecases/usecase.dart';

import 'package:beFit_Del/feature/domain/entities/order_entity.dart';
import 'package:beFit_Del/feature/domain/repositories/order_repository.dart';

class GetUserOrders extends UseCase<List<OrderEntity>, OrderParams>{
  final OrderRepository orderRepository;

  GetUserOrders({required this.orderRepository});

  @override
  Future<Either<Failure, List<OrderEntity>>> call(OrderParams params) async {
    final response = await orderRepository.getUserOrders(isDelivered: params.isDelivered);
    return response;
  }
}

class OrderParams extends Equatable {
  final bool? isDelivered;

  const OrderParams({
    this.isDelivered,
  });

  @override
  List<Object?> get props => [
        isDelivered,
      ];
}