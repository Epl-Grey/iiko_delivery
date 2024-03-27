

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_order_items.dart';
import 'package:iiko_delivery/feature/presentation/bloc/item_cubit/item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final GetOrderItems getOrderItemsUseCase;
  ItemCubit(
    this.getOrderItemsUseCase,
  ) : super(ItemInitial());

  getUserOrders(int userId) async {
    emit(ItemLoadingState());

    final response = await getOrderItemsUseCase(ItemParams(userId: userId));

    response.fold((fail) => emit(GetOrderItemsFailState(message: fail.toString())),
        (success) => emit(GetOrderItemsSuccessState(items: success)));
  }

}