import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders_by_day.dart';
import 'package:iiko_delivery/feature/presentation/bloc/order_cubit/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final GetUserOrders getUserOrdersUseCase;
  final GetUserOrdersByDay getUserOrdersByDay;

  OrderCubit(
    this.getUserOrdersUseCase,
    this.getUserOrdersByDay,
  ) : super(OrderInitial());

  getUserOrders(bool isDelivered, DateTime today) async {
    emit(OrderLoadingState());
    
    final response = isDelivered
        ? await getUserOrdersByDay(OrdersByDayParams(
            year: today.year,
            month: today.month,
            day: today.day,
            isDelivered: true))
        : await getUserOrdersUseCase(const OrderParams(isDelivered: false));
    response.fold(
        (fail) => emit(GetUserOrdersFailState(message: fail.toString())),
        (success) => emit(GetUserOrdersSuccessState(orders: success)));
  }
}
