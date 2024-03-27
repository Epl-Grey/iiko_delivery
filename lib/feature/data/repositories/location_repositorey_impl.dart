import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iiko_delivery/core/error/exception.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/data/datasources/location_remote_data_source.dart';
import 'package:iiko_delivery/feature/domain/repositories/location_repositiry.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepositoryImpl({
    required this.locationRemoteDataSource,
  });

  @override
  Future<Either<Failure, Position>> getPhoneLocation() async{
    try {
      final response = await locationRemoteDataSource.getPhoneLocation();
      return Right(response);
    } on ServerException catch(error){
      return Left(ServerFailure(message: error.message));
    }catch(error){
      return Left(ServerFailure(message: error.toString()));
    }
  }

  
}
