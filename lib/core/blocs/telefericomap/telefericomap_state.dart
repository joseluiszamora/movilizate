part of 'telefericomap_bloc.dart';

sealed class TelefericomapState extends Equatable {
  const TelefericomapState();
  
  @override
  List<Object> get props => [];
}

final class TelefericomapInitial extends TelefericomapState {}
