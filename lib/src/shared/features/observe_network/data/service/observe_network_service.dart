import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract interface class ConnectivityService {
  Stream<List<ConnectivityResult>> observeRaw();
  Future<List<ConnectivityResult>> currentRaw();
}

@LazySingleton(as: ConnectivityService)
class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;
  ConnectivityServiceImpl(this._connectivity);

  @override
  Stream<List<ConnectivityResult>> observeRaw() => _connectivity.onConnectivityChanged;

  @override
  Future<List<ConnectivityResult>> currentRaw() => _connectivity.checkConnectivity();
}