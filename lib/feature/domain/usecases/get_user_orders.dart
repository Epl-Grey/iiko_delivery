import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/core/usecases/usecase.dart';

import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/domain/repositories/order_repository.dart';

class GetUserOrders extends UseCase<List<OrderEntity>, OrderParams>{
  final OrderRepository orderRepository;

  GetUserOrders({required this.orderRepository});

  @override
  Future<Either<Failure, List<OrderEntity>>> call(OrderParams params) async {
    final response = await orderRepository.getUserOrders(params.isDelivered);
    return response;
  }
}

class OrderParams extends Equatable {
  final bool isDelivered;

  const OrderParams({
    required this.isDelivered,
  });

  @override
  List<Object?> get props => [
        isDelivered,
      ];
}