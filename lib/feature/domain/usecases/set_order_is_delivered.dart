import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/core/usecases/usecase.dart';
import 'package:beFit_Del/feature/domain/repositories/order_repository.dart';

class SetOrderIsDelivered extends UseCase<void, SetDeliveredParams>{
  final OrderRepository orderRepository;

  SetOrderIsDelivered({required this.orderRepository});

  @override
  Future<Either<Failure, void>> call(SetDeliveredParams params) async{
    final response = await orderRepository.setOrderIsDelivered(params.orderId, params.isDelivered);
    return response;
  }
}

class SetDeliveredParams extends Equatable {
  final int orderId;
  final bool isDelivered;

  const SetDeliveredParams({
    required this.orderId,
    required this.isDelivered,
  });

  @override
  List<Object?> get props => [
        isDelivered,
      ];
}