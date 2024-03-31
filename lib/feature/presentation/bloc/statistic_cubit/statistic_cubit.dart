import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders_by_month.dart';
import 'package:iiko_delivery/feature/presentation/bloc/statistic_cubit/statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  final GetUserOrdersByMonth getUserOrdersByMonthUseCases;
  StatisticCubit(
    this.getUserOrdersByMonthUseCases,
  ) : super(StatisticInitial());

  getUserOrdersByMonth(int year, int month, bool? isDelivered) async {
    emit(StatisticLoadingState());

    final response = await getUserOrdersByMonthUseCases(OrdersByMonthParams(year: year, month: month, isDelivered: isDelivered));

    response.fold((fail) => emit(GetUserStatisticsFailState(message: fail.toString())),
        (success) => emit(GetUserStatisticsSuccessState(orders: success)));
  }
}