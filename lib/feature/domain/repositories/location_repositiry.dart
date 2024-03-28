import 'package:dartz/dartz.dart';
import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/feature/data/models/location_model.dart';


abstract class LocationRepository {
  Future<Either<Failure, LocationModel>> getPhoneLocation(String address);
}
