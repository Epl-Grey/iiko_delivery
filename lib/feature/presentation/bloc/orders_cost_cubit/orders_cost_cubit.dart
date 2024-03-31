import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:iiko_delivery/feature/domain/entities/item_entity.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_order_items.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders_by_day.dart';

part 'orders_cost_state.dart';

class OrdersCostCubit extends Cubit<OrdersCostState> {
  final GetUserOrders getUserOrders;
  final GetUserOrdersByDay getUserOrdersByDay;

  final GetOrderItems getOrderItems;

  OrdersCostCubit(
      {required this.getUserOrders,
      required this.getUserOrdersByDay,
      required this.getOrderItems})
      : super(OrdersCostInitial());

  getOrdersCost(bool isDelivered) async {
    emit(OrdersCostLoading());

    final today = DateTime.now();

    final response = isDelivered
        ? await getUserOrdersByDay(OrdersByDayParams(
            year: today.year,
            month: today.month,
            day: today.day,
            isDelivered: true))
        : await getUserOrders(const OrderParams(isDelivered: false));

    response.fold(
        (fail) => emit(OrdersCostFailure(message: fail.toString())),
        (orders) async {
          Map<int, Decimal> costs = {};

          for (final order in orders){
            final itemsResponse = await getOrderItems(ItemParams(orderId: int.parse(order.orderNumber)));

            itemsResponse.fold(
              (failure) => emit(OrdersCostFailure(message: failure.toString())),
              (itemsFromResponse) {
                costs.putIfAbsent(order.id, () {
                  Decimal orderCost = Decimal.zero;
                  for(final item in itemsFromResponse){
                    orderCost += item.cost;
                  }
                  return orderCost;
                });
              }
            );
          }

          if(state is OrdersCostFailure) return;

          emit(OrdersCostSuccess(costs: costs));
        });
  }
}
