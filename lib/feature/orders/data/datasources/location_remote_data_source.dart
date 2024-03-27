import 'package:geolocator/geolocator.dart';
abstract class LocationRemoteDataSource {
  Future<Position> getPhoneLocation();
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  @override
  Future<Position> getPhoneLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
