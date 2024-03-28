import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:iiko_delivery/core/error/failure.dart';
import 'package:iiko_delivery/core/usecases/usecase.dart';
import 'package:iiko_delivery/feature/data/models/location_model.dart';
import 'package:iiko_delivery/feature/domain/entities/location_entity.dart';

import 'package:iiko_delivery/feature/domain/repositories/location_repositiry.dart';

class GetPhoneLocation extends UseCase<LocationEntity, LocationParams>{
  final LocationRepository locationRepository;

  GetPhoneLocation({required this.locationRepository});

  @override
  Future<Either<Failure, LocationModel>> call(LocationParams params) async {
    final response = await locationRepository.getPhoneLocation(params.address);
    return response;
  }
}

class LocationParams extends Equatable {
  final String address;

  const LocationParams({
    required this.address,
  });

  @override
  List<Object?> get props => [
        address,
      ];
}