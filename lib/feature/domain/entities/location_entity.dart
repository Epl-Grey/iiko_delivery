import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationEntity extends Equatable {
  final Position phone;
  final List<Location> locations;

  const LocationEntity({
    required this.phone,
    required this.locations,
  });

  @override
  get props => [
        phone,
        locations,
      ];
}
