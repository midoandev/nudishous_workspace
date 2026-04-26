import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../services/connectivity_service.dart';

enum ConnectivityStatus { online, offline }

@injectable
class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final ConnectivityService _service;
  StreamSubscription? _subscription;

  ConnectivityCubit(this._service) : super(ConnectivityStatus.online) {
    _monitorConnection();
  }

  void _monitorConnection() async {
    // Initial check
    final isOnline = await _service.isConnected;
    emit(isOnline ? ConnectivityStatus.online : ConnectivityStatus.offline);

    // Continuous listener
    _subscription = _service.onConnectivityChanged.listen((isOnline) {
      emit(isOnline ? ConnectivityStatus.online : ConnectivityStatus.offline);
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}