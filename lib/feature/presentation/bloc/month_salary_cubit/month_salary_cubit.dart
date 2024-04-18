import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/entities/item_entity.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_order_items.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders_by_month.dart';
import 'package:iiko_delivery/feature/presentation/bloc/month_salary_cubit/month_salary_state.dart';

class MonthSalaryCubit extends Cubit<MonthSalaryState> {
  final GetUserOrdersByMonth getUserOrdersByMonthUseCase;
  final GetOrderItems getOrderItems;
  MonthSalaryCubit(
    this.getUserOrdersByMonthUseCase,
    this.getOrderItems,
  ) : super(MonthSalaryInitial());

  getUserOrdersByMonth(DateTime date) async {
    emit(MonthSalaryLoading());
    Decimal salaryByMonth = Decimal.zero;
    List<ItemEntity> items = [];
    final ordersResponse = await getUserOrdersByMonthUseCase(
        OrdersByMonthParams(
            year: date.year, month: date.month, isDelivered: true));

    ordersResponse
        .fold((fail) => emit(MonthSalaryFailure(message: fail.toString())),
            (orders) async {
      for (var order in orders) {
        final itemsResponse = await getOrderItems(
            ItemParams(orderId: int.parse(order.orderNumber)));
        itemsResponse.fold(
            (failure) => emit(MonthSalaryFailure(message: failure.toString())),
            (itemsFromResponse) => itemsFromResponse.forEach(items.add));
      }

      for (var item in items) {
        Decimal orderSalary = (item.cost / Decimal.fromInt(100)).toDecimal() *
            Decimal.fromInt(40);
        salaryByMonth += orderSalary * Decimal.fromInt(item.count);
      }
      emit(MonthSalarySuccess(salary: salaryByMonth));
    });
  }
}
