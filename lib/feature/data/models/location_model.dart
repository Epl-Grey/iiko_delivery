import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:beFit_Del/feature/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.phone,
    required super.locations,
  });

  factory LocationModel.fromJson(Map<String, dynamic> map) {
    return LocationModel(
      phone: map['phone'] as Position,
      locations: map['locations'] as List<Location>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'locations': locations,
    };
  }

}
