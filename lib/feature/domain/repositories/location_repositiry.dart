import 'package:dartz/dartz.dart';
import 'package:beFit_Del/core/error/failure.dart';
import 'package:beFit_Del/feature/data/models/location_model.dart';


abstract class LocationRepository {
  Future<Either<Failure, LocationModel>> getPhoneLocation(String address);
}
