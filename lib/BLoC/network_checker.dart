import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart'; //Internet connection checker

class NetworkChecker extends Bloc<NetworkCheckerEvent, bool> {
  NetworkChecker() : super(true) {
    on<CheckInternetConnectionEvent>(_onCeckInternetConnectionEvent);
  }

  Future<void> _onCeckInternetConnectionEvent<NetworkCheckerEvent>(
      CheckInternetConnectionEvent event, Emitter<bool> emit) async {
        bool result = true;
        print("Это результат до проверки $result");
    result = await DataConnectionChecker().hasConnection;
    print("Это результат проверки $result");
    emit(result ? true : false);
  }
}

abstract class NetworkCheckerEvent {}

class CheckInternetConnectionEvent extends NetworkCheckerEvent {}
