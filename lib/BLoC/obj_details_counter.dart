import 'package:flutter_bloc/flutter_bloc.dart';

class CounterNav extends Bloc<CounterEvent, int> {
  CounterNav() : super(0) {
    on<CounterIncrementEvent>(_onIncrement);
    on<CounterDecrementEvent>(_onDecrement);
    on<CounterResetEvent>(_onReset);
  }

  _onIncrement<CounterIncrementEvent>(
      CounterIncrementEvent event, Emitter<int> emit) {
        emit(state+1);
      }
  _onDecrement<CounterDecrementEvent>(
      CounterDecrementEvent event, Emitter<int> emit) {
        emit(state-1);
      }

   _onReset<CounterResetEvent>(
      CounterResetEvent event, Emitter<int> emit) {
        emit(0);
      }
}

abstract class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterDecrementEvent extends CounterEvent {}

class CounterResetEvent extends CounterEvent {}
