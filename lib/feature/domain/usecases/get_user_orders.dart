import 'package:dartz/dartz.dart';

import 'package:iiko_delivery/core/error/failure.dart';

import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/domain/repositories/order_repository.dart';

class GetUserOrders {
  final OrderRepository orderRepository;

  GetUserOrders({required this.orderRepository});

  Future<Either<Failure, List<OrderEntity>>> call() async {
    final response = await orderRepository.getUserOrders();
    return response;
  }
}
