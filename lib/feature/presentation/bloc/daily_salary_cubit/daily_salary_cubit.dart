import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beFit_Del/feature/domain/entities/item_entity.dart';
import 'package:beFit_Del/feature/domain/usecases/get_order_items.dart';
import 'package:beFit_Del/feature/domain/usecases/get_user_orders_by_day.dart';

part 'daily_salary_state.dart';

class DailySalaryCubit extends Cubit<DailySalaryState> {
  final GetUserOrdersByDay getUserOrdersByDay;
  final GetOrderItems getOrderItems;

  DailySalaryCubit(
      {required this.getUserOrdersByDay, required this.getOrderItems})
      : super(DailySalaryInitial());

  getDailySalary(DateTime today) async {
    emit(DailySalaryLoading());

    final ordersResponse = await getUserOrdersByDay(OrdersByDayParams(
        year: today.year,
        month: today.month,
        day: today.day,
        isDelivered: true));

    Decimal salary = Decimal.fromInt(0);

    ordersResponse.fold(
        (failure) => emit(DailySalaryFailure(message: failure.toString())),
        (orders) async {
      List<ItemEntity> items = [];

      for (var order in orders) {
        final itemsResponse = await getOrderItems(
            ItemParams(orderId: int.parse(order.orderNumber)));
        itemsResponse.fold(
            (failure) => emit(DailySalaryFailure(message: failure.toString())),
            (itemsFromResponse) => itemsFromResponse.forEach(items.add));
      }

      if (state is DailySalaryFailure) return;

      for (var item in items) {
        Decimal orderSalary = (item.cost / Decimal.fromInt(100)).toDecimal() *
            Decimal.fromInt(40);
        salary += orderSalary * Decimal.fromInt(item.count);
      }
      emit(DailySalarySuccess(salary: salary));
    });
  }
}
