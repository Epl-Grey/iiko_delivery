import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import 'package:iiko_delivery/core/error/failure.dart';

import 'package:iiko_delivery/feature/orders/domain/repositories/location_repositiry.dart';

class GetPhoneLocation {
  final LocationRepository locationRepository;

  GetPhoneLocation({required this.locationRepository});

  Future<Either<Failure, Position>> call() async {
    final response = await locationRepository.getPhoneLocation();
    return response;
  }
}
