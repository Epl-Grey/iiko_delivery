import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/domain/usecases/set_order_is_delivered.dart';

import 'package:iiko_delivery/feature/presentation/bloc/set_delivered_cubit/set_delivered_state.dart';


class SetDeliveredCubit extends Cubit<SetDeliveredState> {
  final SetOrderIsDelivered setOrderIsDeliveredUseCase;

  SetDeliveredCubit({required this.setOrderIsDeliveredUseCase}) : super(SetDeliveredInitial());

  setOrderIsDelivered(int id, bool isDelivered) async {
    emit(SetDeliveredStart());

    final failureOrUser = await setOrderIsDeliveredUseCase(SetDeliveredParams(orderId: id, isDelivered: isDelivered));
    emit(failureOrUser.fold(
        (failure) => SetDeliveredError(message: mapFailureFromMessage(failure)),
        (delivered) => SetDeliveredLoaded()));
  }

  String mapFailureFromMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return "ServerFailure";
      default:
        return "Unexpected error";
    }
  }
}