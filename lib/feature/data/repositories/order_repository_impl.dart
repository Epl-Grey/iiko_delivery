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
  Future<Either<ServerFailure, List<OrderModel>>> getUserOrders() async {
    try{
      final response = await remoteDataSource.getUserOrders();
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }

}
