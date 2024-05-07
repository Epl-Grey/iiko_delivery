import 'package:dartz/dartz.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/feature/domain/entities/item_entity.dart';

abstract class ItemRepository {
  Future<Either<Failure, List<ItemEntity>>> getOrderItems(int orderId);
}
