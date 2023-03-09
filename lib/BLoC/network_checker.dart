import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart'; //Internet connection checker
import '../Widgets/determine_current_position.dart';


class NetworkChecker extends Bloc<NetworkCheckerEvent, dynamic> {
  NetworkChecker() : super("checking") {
    on<CheckInternetConnectionEvent>(_onCeckInternetConnectionEvent);
  }

  Future<void> _onCeckInternetConnectionEvent<NetworkCheckerEvent>(
      CheckInternetConnectionEvent event, Emitter<dynamic> emit) async {

    bool result = await DataConnectionChecker().hasConnection;
    print("Это результат проверки $result");
    if (result == true) {
      print("Im before launching geo determination");
      await determinePosition();
      await Future.delayed(const Duration(seconds: 5));
      emit(true);
    } else {
      await Future.delayed(const Duration(seconds: 5));
      emit(false);
    }
  }
}

abstract class NetworkCheckerEvent {}

class CheckInternetConnectionEvent extends NetworkCheckerEvent {}
