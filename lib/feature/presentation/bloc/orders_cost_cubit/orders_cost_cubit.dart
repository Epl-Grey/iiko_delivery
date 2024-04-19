import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beFit_Del/feature/domain/usecases/get_order_items.dart';
import 'package:beFit_Del/feature/domain/usecases/get_user_orders.dart';
import 'package:beFit_Del/feature/domain/usecases/get_user_orders_by_day.dart';

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

    final response = await getUserOrders(const OrderParams());

    response.fold(
        (fail) => emit(OrdersCostFailure(message: fail.toString())),
        (orders) async {
          Map<int, Decimal> costs = {};
          Map<int, Decimal> costsForRecent = {};
          for (final order in orders){
            final itemsResponse = await getOrderItems(ItemParams(orderId: int.parse(order.orderNumber)));

            itemsResponse.fold(
              (failure) => emit(OrdersCostFailure(message: failure.toString())),
              (itemsFromResponse) {
                costs.putIfAbsent(order.id, () {
                  Decimal orderCost = Decimal.zero;
                  for(final item in itemsFromResponse){
                    orderCost += item.cost * Decimal.fromInt(item.count);
                  }
                  return orderCost;
                });
                costsForRecent.putIfAbsent(order.id, () {
                  Decimal orderCost = Decimal.zero;
                  for(final item in itemsFromResponse){
                    orderCost += item.cost * Decimal.fromInt(item.count);
                  }
                  Decimal orderSalary = (orderCost / Decimal.fromInt(100)).toDecimal() * Decimal.fromInt(40);
                  return orderSalary;
                });
              }
            );
          }

          if(state is OrdersCostFailure) return;

          emit(OrdersCostSuccess(costs: costs, costsForRecent: costsForRecent));
        });
  }
}
