
import 'package:dartz/dartz.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/core/usecases/usecase.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/domain/repositories/order_repository.dart';

class GetUserOrders extends UseCase<List<OrderEntity>, void> {
  final OrderRepository orderRepository;

  GetUserOrders({required this.orderRepository});


     @override
       Future<Either<Failure, List<OrderEntity>>> call(params) async {
      return await orderRepository.getUserOrders();
  }
}

