import 'package:beFit_Del/feature/domain/entities/item_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:beFit_Del/core/error/exception.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/feature/data/datasources/item_remote_data_source.dart';
import 'package:beFit_Del/feature/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDataSource itemRemoteDataSource;

  ItemRepositoryImpl({
    required this.itemRemoteDataSource,
  });

  @override
  Future<Either<ServerFailure, List<ItemEntity>>> getOrderItems(int orderId) async {
    try{
      final response = await itemRemoteDataSource.getOrderItems(orderId);
      return Right(response.map((e) => ItemEntity(id: e.id, orderId: e.orderId, name: e.name, count: e.count, cost: e.cost)).toList());
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }

}
