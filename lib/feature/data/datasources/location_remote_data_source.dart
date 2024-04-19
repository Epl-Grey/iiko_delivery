import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:beFit_Del/feature/data/models/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<LocationModel> getPhoneLocation(String address);
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  @override
  Future<LocationModel> getPhoneLocation(String address) async {
    List<Location> locations = await locationFromAddress(address);
    Position phone = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LocationModel(phone: phone, locations: locations);
  }
}
