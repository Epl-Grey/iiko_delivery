import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiko_delivery/feature/domain/usecases/get_phone_location.dart';
import 'package:iiko_delivery/feature/presentation/bloc/location_cubit/location_state.dart';


class LocationCubit extends Cubit<LocationState> {
  final GetPhoneLocation getPhoneLocation;
  LocationCubit(
    this.getPhoneLocation,
  ) : super(LocationInitial());

  getUserOrders() async {
    emit(LocationLoadingState());

    final response = await getPhoneLocation();

    response.fold((fail) => emit(GetLocationFailState(message: fail.toString())),
        (success) => emit(GetLocationSuccessState(position: success)));
  }

}