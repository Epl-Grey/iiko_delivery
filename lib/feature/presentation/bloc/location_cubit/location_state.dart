import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoadingState extends LocationState{}


class GetLocationSuccessState extends LocationState {
  final Position position;
  
  const GetLocationSuccessState({
    required this.position,
  });

}

class GetLocationFailState extends LocationState {
  final String message;
  
  const GetLocationFailState({
    required this.message
  });

  @override
  List<Object> get props => [message];
}
