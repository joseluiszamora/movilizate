part of 'parking_bloc.dart';

abstract class ParkingEvent extends Equatable {
  const ParkingEvent();

  @override
  List<Object> get props => [];
}

// Evento para cargar los parqueos
class LoadParkings extends ParkingEvent {
  const LoadParkings();

  @override
  List<Object> get props => [];
}

// Evento opcional para filtrar parqueos cercanos
class FilterNearParkings extends ParkingEvent {
  final double radiusInMeters; // Radio en metros para considerar "cercano"

  const FilterNearParkings(this.radiusInMeters);

  @override
  List<Object> get props => [radiusInMeters];
}
