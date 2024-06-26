

import 'package:dartz/dartz.dart';
import 'package:beFit_Del/core/error/exception.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/feature/data/datasources/item_remote_data_source.dart';
import 'package:beFit_Del/feature/data/models/item_model.dart';
import 'package:beFit_Del/feature/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDataSource itemRemoteDataSource;

  ItemRepositoryImpl({
    required this.itemRemoteDataSource,
  });

  @override
  Future<Either<ServerFailure, List<ItemModel>>> getOrderItems(int orderId) async {
    try{
      final response = await itemRemoteDataSource.getOrderItems(orderId);
      return Right(response);
    }on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }

}
