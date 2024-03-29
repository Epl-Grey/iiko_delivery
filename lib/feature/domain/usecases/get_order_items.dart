import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/core/usecases/usecase.dart';
import 'package:iiko_delivery/feature/domain/entities/item_entity.dart';

import 'package:iiko_delivery/feature/domain/repositories/item_repository.dart';

class GetOrderItems extends UseCase<List<ItemEntity>, ItemParams> {
  final ItemRepository orderRepository;

  GetOrderItems({required this.orderRepository});

  @override
   Future<Either<Failure, List<ItemEntity>>> call(ItemParams params) async {
    final response = await orderRepository.getOrderItems(params.userId);
    return response;
  }
}

class ItemParams extends Equatable {
  final int userId;

  const ItemParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [
        userId,
      ];
}
