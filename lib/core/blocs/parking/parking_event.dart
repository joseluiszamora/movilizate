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

class StartPeriodicUpdates extends ParkingEvent {
  const StartPeriodicUpdates();

  @override
  List<Object> get props => [];
}

class StopPeriodicUpdates extends ParkingEvent {
  const StopPeriodicUpdates();

  @override
  List<Object> get props => [];
}

class LoadNearbyParkings extends ParkingEvent {
  final double latitude;
  final double longitude;
  final double radius;
  final FilterOptions? filterOptions;

  const LoadNearbyParkings({
    required this.latitude,
    required this.longitude,
    this.radius = 1.0,
    this.filterOptions,
  });

  @override
  List<Object> get props => [
    latitude,
    longitude,
    radius,
    if (filterOptions != null) filterOptions!,
  ];
}

class LoadParkingDetails extends ParkingEvent {
  final String parkingId;

  const LoadParkingDetails(this.parkingId);

  @override
  List<Object> get props => [parkingId];
}

class FilterParkings extends ParkingEvent {
  final FilterOptions filterOptions;

  const FilterParkings(this.filterOptions);

  @override
  List<Object> get props => [filterOptions];
}
