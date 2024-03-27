import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iiko_delivery/core/error/failure.dart';


abstract class LocationRepository {
  Future<Either<Failure, Position>> getPhoneLocation();
}
