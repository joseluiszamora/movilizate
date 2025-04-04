part of 'parking_bloc.dart';

abstract class ParkingState extends Equatable {
  const ParkingState();

  @override
  List<Object> get props => [];
}

// Estado inicial/cargando
class ParkingLoading extends ParkingState {}

// Estado cargado con datos
class ParkingLoaded extends ParkingState {
  final LatLng userPosition;
  final List<Parking> parkings;

  const ParkingLoaded({required this.userPosition, required this.parkings});

  @override
  List<Object> get props => [userPosition, parkings];
}

class ParkingDetailLoaded extends ParkingState {
  final Parking parking;

  const ParkingDetailLoaded(this.parking);

  @override
  List<Object> get props => [parking];
}

// Estado de error
class ParkingError extends ParkingState {
  final String message;

  const ParkingError(this.message);

  @override
  List<Object> get props => [message];
}
