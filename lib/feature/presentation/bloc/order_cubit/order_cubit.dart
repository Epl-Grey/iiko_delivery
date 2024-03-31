import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_user_orders.dart';
import 'package:iiko_delivery/feature/presentation/bloc/order_cubit/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final GetUserOrders getUserOrdersUseCase;
  OrderCubit(
    this.getUserOrdersUseCase,
  ) : super(OrderInitial());

  getUserOrders(bool isDelivered) async {
    emit(OrderLoadingState());

    final response = await getUserOrdersUseCase(OrderParams(isDelivered: isDelivered));

    response.fold((fail) => emit(GetUserOrdersFailState(message: fail.toString())),
        (success) => emit(GetUserOrdersSuccessState(orders: success)));
  }
}