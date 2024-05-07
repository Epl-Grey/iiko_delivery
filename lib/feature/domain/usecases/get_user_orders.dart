import 'package:beFit_Del/feature/domain/entities/item_entity.dart';
import 'package:beFit_Del/feature/domain/repositories/item_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/core/usecases/usecase.dart';

import 'package:beFit_Del/feature/domain/entities/order_entity.dart';
import 'package:beFit_Del/feature/domain/repositories/order_repository.dart';

class GetUserOrders extends UseCase<List<OrderEntity>, OrderParams> {
  final OrderRepository orderRepository;
  final ItemRepository itemRepository;

  GetUserOrders({required this.orderRepository, required this.itemRepository});

  @override
  Future<Either<Failure, List<OrderEntity>>> call(OrderParams params) async {
    final response =
        await orderRepository.getUserOrders(isDelivered: params.isDelivered);

    // Either<Failure, List<OrderEntity>> ordersResponse =
    //     Left(ServerFailure(message: "Unexpected Error!"));

    Failure? useCaseFailure;
    List<OrderEntity> orders = [];

    response.fold(
      (failure) => useCaseFailure = failure,
      (responseOrders) async {
        for (OrderEntity order in responseOrders) {
          final itemResponse = await itemRepository.getOrderItems(order.id);
          itemResponse.fold(
            (failure) => useCaseFailure = failure,
            (items) {
              order.items.addAll(items);
              orders.add(order);
            },
          );
        }
      },
    );

    return useCaseFailure == null ? Right(orders) : Left(useCaseFailure!);

    // await response.fold(
    //   (failure) async => orders = Left(failure),  // Get Orders Failure
    //   (responseOrders) async => orders = Right(await Future.wait(  // Get Orders Success
    //     responseOrders.map((order) async {  // Get items for each order
    //       (await itemRepository.getOrderItems(order.id)).fold(
    //         (failure) => orders = orders = Left(failure),
    //         (items) => order.items.addAll(items),
    //       );
    //       return order;
    //     }).toList(),
    //   )),
    // );

    // return orders;
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
