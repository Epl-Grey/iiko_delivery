import 'package:dartz/dartz.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/domain/repositories/order_repository.dart';

class SetOrderIsDelivered{
  final OrderRepository orderRepository;

  SetOrderIsDelivered({required this.orderRepository});

  Future<Either<Failure, void>> call(int id, bool isDelivered) async{
    final response = await orderRepository.setOrderIsDelivered(id, isDelivered);
    return response;
  }
}