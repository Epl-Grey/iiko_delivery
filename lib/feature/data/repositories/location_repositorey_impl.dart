import 'package:dartz/dartz.dart';
import 'package:beFit_Del/core/error/exception.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/feature/data/datasources/location_remote_data_source.dart';
import 'package:beFit_Del/feature/data/models/location_model.dart';
import 'package:beFit_Del/feature/domain/repositories/location_repositiry.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepositoryImpl({
    required this.locationRemoteDataSource,
  });

  @override
  Future<Either<Failure, LocationModel>> getPhoneLocation(String address) async{
    try {
      final response = await locationRemoteDataSource.getPhoneLocation(address);
      return Right(response);
    } on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }

  
}
