import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionCubit extends Cubit<ConnectionStatus> {
  ConnectionCubit({required this.connectionChecker})
    : super(const ConnectionInitial()) {
    monitorConnection();
  }
  final InternetConnection connectionChecker;
  StreamSubscription<InternetStatus>? _connectionSubscription;

  void monitorConnection() {
    _connectionSubscription = connectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetStatus.connected:
          emitConnected();
        case InternetStatus.disconnected:
          emitDisconnected();
      }
    });
  }

  void emitConnected() => emit(const ConnectionSuccess());
  void emitDisconnected() => emit(const ConnectionFailure());
  void emitLoading() => emit(const ConnectionLoading());

  Future<void> checkConnection() async {
    emitLoading();
    final isConnected = await connectionChecker.hasInternetAccess;
    isConnected ? emitConnected() : emitDisconnected();
  }

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    return super.close();
  }
}

abstract class ConnectionStatus {
  const ConnectionStatus();
}

class ConnectionInitial extends ConnectionStatus {
  const ConnectionInitial();
}

class ConnectionLoading extends ConnectionStatus {
  const ConnectionLoading();
}

class ConnectionSuccess extends ConnectionStatus {
  const ConnectionSuccess();
}

class ConnectionFailure extends ConnectionStatus {
  const ConnectionFailure();
}
