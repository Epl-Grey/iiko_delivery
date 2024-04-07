import 'package:dartz/dartz.dart';
import 'package:iiko_delivery/core/error/exception.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/data/datasources/order_remote_data_source.dart';
import 'package:iiko_delivery/feature/data/models/order_model.dart';
import 'package:iiko_delivery/feature/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<ServerFailure, List<OrderModel>>> getUserOrders(bool isDelivered) async {
    return await _getUsers(() =>
      remoteDataSource.getUserOrders(isDelivered)
    );
  }
  
  @override
  Future<Either<ServerFailure, List<OrderModel>>> getUserOrdersByDateRange(DateTime start, DateTime end, {bool? isDelivered}) async {
    return await _getUsers(() => 
      remoteDataSource.getUserOrdersByDateRange(start, end, isDelivered: isDelivered)
    );
  }

  @override
  Future<Either<ServerFailure, void>> setOrderIsDelivered(int id, bool isDelivered) async {
    try{
      final response = await remoteDataSource.setOrderIsDelivered(id, isDelivered);
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }

  Future<Either<ServerFailure, List<OrderModel>>> _getUsers(
    Future<List<OrderModel>> Function() getUsers
  ) async {
    try{
      final response = await getUsers();
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
