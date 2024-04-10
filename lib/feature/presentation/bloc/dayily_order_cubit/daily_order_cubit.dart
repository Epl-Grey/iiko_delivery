import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders_by_day.dart';
import 'package:iiko_delivery/feature/presentation/bloc/dayily_order_cubit/daily_order_state.dart';

class DailyOrderCubit extends Cubit<DailyOrderState> {
  final GetUserOrdersByDay getUserOrdersByDayUseCase;

  DailyOrderCubit(
    this.getUserOrdersByDayUseCase,
  ) : super(DailyOrderInitial());

  getUserOrdersByDay(bool isDelivered, DateTime today) async {
    emit(DailyOrderLoadingState());

    final response = await getUserOrdersByDayUseCase(OrdersByDayParams(
        year: today.year,
        month: today.month,
        day: today.day,
        isDelivered: true));

    response.fold(
        (fail) => emit(GetUserDailyOrdersFailState(message: fail.toString())),
        (success) => emit(GetUserDailyOrdersSuccessState(orders: success)));
  }
}
