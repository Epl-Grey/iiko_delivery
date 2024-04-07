import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_order_items.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders_by_month.dart';
import 'package:iiko_delivery/feature/presentation/bloc/statistic_cubit/statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  final GetUserOrdersByMonth getUserOrdersByMonth;
  final GetOrderItems getOrderItems;

  StatisticCubit(
      {required this.getUserOrdersByMonth, required this.getOrderItems})
      : super(StatisticInitial());

  getMonthSalary(DateTime date) async {
    emit(StatisticLoading());
    List<Decimal> salary = [];
    final ordersResponse = await getUserOrdersByMonth(OrdersByMonthParams(
        year: date.year, month: date.month, isDelivered: true));
    DateTime(date.year, date.month + 1, 0).day;
    ordersResponse
        .fold((failure) => emit(StatisticFailure(message: failure.toString())),
            (orders) async {
      Map<int, List<OrderEntity>> ordersByDay = {};
      for (var order in orders) {
        if (ordersByDay.containsKey(order.orderDate.day)) {
          ordersByDay[order.orderDate.day]!.add(order);
        } else {
          ordersByDay[order.orderDate.day] = <OrderEntity>[order];
        }
      }
      Map<int, Decimal> salaryByDates = {};
      for (var key in ordersByDay.keys) {
        Decimal someSalary = Decimal.zero;
        for (var order in ordersByDay[key]!) {
          final itemsResponse = await getOrderItems(
              ItemParams(orderId: int.parse(order.orderNumber)));
          itemsResponse.fold(
              (failure) => emit(StatisticFailure(message: failure.toString())),
              (itemsFromResponse) {
            for (var item in itemsFromResponse) {
              someSalary += item.cost * Decimal.fromInt(item.count);
            }
          });
        }
        salaryByDates[key] = someSalary;

      }
      for(int i = 1; i <= DateTime(date.year, date.month + 1, 0).day; i++) {
        if(salaryByDates.containsKey(i)) {
          salary.add(salaryByDates[i]!);
        } else {
          salary.add(Decimal.zero);
        }
      }
      if (state is StatisticFailure) return;

      emit(StatisticSuccess(salary: salary, length: salary.length));
    });
  }
}
