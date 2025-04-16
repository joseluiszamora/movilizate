import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'telefericomap_event.dart';
part 'telefericomap_state.dart';

class TelefericomapBloc extends Bloc<TelefericomapEvent, TelefericomapState> {
  TelefericomapBloc() : super(TelefericomapInitial()) {
    on<TelefericomapEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
