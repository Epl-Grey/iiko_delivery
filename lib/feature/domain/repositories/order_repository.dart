import 'package:dartz/dartz.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getUserOrders({bool? isDelivered});
  Future<Either<Failure, void>> setOrderIsDelivered(int id, bool isDelivered);
  Future<Either<Failure, List<OrderEntity>>> getUserOrdersByDateRange(DateTime start, DateTime end, {bool? isDelivered});
}
