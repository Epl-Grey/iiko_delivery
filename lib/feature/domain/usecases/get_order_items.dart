import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/core/usecases/usecase.dart';
import 'package:beFit_Del/feature/domain/entities/item_entity.dart';

import 'package:beFit_Del/feature/domain/repositories/item_repository.dart';

class GetOrderItems extends UseCase<List<ItemEntity>, ItemParams> {
  final ItemRepository orderRepository;

  GetOrderItems({required this.orderRepository});

  @override
   Future<Either<Failure, List<ItemEntity>>> call(ItemParams params) async {
    final response = await orderRepository.getOrderItems(params.orderId);
    return response;
  }
}

class ItemParams extends Equatable {
  final int orderId;

  const ItemParams({
    required this.orderId,
  });

  @override
  List<Object?> get props => [
        orderId,
      ];
}
