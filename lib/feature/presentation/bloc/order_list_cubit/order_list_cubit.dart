import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders.dart';
import 'package:iiko_delivery/feature/presentation/bloc/order_list_cubit/order_list_state.dart';

class OrderListCubit extends Cubit<OrderState> {
  final GetUserOrders getUserOrders;

  bool isFerstFetch = true;

  OrderListCubit({required this.getUserOrders}) : super(OrderEmpty());

  void loadOrder() async {
    if (state is OrderLoading) {
      return;
    }

    final currentState = state;

    var oldOrder = <OrderEntity>[];

    if (currentState is OrderLoaded) {
      oldOrder = currentState.ordersList;
    }

    emit(OrderLoading(oldOrder, isFirstFetch: isFerstFetch));

    final failureOrOrder = await getUserOrders(isFerstFetch);

    failureOrOrder.fold((error) => OrderError(message: mapFailureFromMessage(error)), (order) => OrderLoaded(ordersList: order));
  }
  
  String mapFailureFromMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailure";
      default:
        return "Unexpected error";
    }
  }
}
