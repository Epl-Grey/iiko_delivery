import 'package:dartz/dartz.dart';
import 'package:iiko_delivery/core/error/exception.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/core/platform/network_info.dart';
import 'package:iiko_delivery/feature/data/datasources/order_remote_data_source.dart';
import 'package:iiko_delivery/feature/domain/entities/order_entity.dart';
import 'package:iiko_delivery/feature/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders() async {
    if (await networkInfo.isConndected) {
      try {
        final remoteOrder = await remoteDataSource.getUserOrders();
        return Right(remoteOrder);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
