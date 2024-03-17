
import 'package:equatable/equatable.dart';
import 'package:iiko_delivery/feature/orders/domain/entities/item_entity.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoadingState extends ItemState{}


class GetOrderItemsSuccessState extends ItemState {
  final List<ItemEntity> items;
  
  const GetOrderItemsSuccessState({
    required this.items,
  });

  @override
  List<Object> get props => [items];
}

class GetOrderItemsFailState extends ItemState {
  final String message;
  
  const GetOrderItemsFailState({
    required this.message
  });

  @override
  List<Object> get props => [message];
}
