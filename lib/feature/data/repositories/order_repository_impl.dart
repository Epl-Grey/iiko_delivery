import 'package:beFit_Del/feature/domain/entities/order_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:beFit_Del/core/error/exception.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/feature/data/datasources/order_remote_data_source.dart';
import 'package:beFit_Del/feature/data/models/order_model.dart';
import 'package:beFit_Del/feature/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<ServerFailure, List<OrderEntity>>> getUserOrders(
      {bool? isDelivered}) async {
    return await _getOrders(
        () => remoteDataSource.getUserOrders(isDelivered: isDelivered));
  }

  @override
  Future<Either<ServerFailure, List<OrderEntity>>> getUserOrdersByDateRange(
      DateTime start, DateTime end,
      {bool? isDelivered}) async {
    return await _getOrders(() => remoteDataSource
        .getUserOrdersByDateRange(start, end, isDelivered: isDelivered));
  }

  @override
  Future<Either<ServerFailure, void>> setOrderIsDelivered(
      int id, bool isDelivered) async {
    try {
      final response =
          await remoteDataSource.setOrderIsDelivered(id, isDelivered);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  Future<Either<ServerFailure, List<OrderEntity>>> _getOrders(
      Future<List<OrderModel>> Function() getOrders) async {
    try {
      final response = await getOrders();
      return Right(response
          .map((e) => OrderEntity(
                id: e.id,
                orderNumber: e.orderNumber,
                address: e.address,
                isDelivered: e.isDelivered,
                clientPhone: e.clientPhone,
                clientName: e.clientName,
                orderDate: e.orderDate,
                neadToCall: e.neadToCall,
                paymentMethod: e.paymentMethod,
                items: [],
              ))
          .toList());
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
