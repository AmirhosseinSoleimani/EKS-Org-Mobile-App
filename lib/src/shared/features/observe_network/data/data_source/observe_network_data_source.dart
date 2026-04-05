import 'package:connectivity_plus/connectivity_plus.dart';


abstract interface class ObserveNetworkDataSource {
  Stream<ConnectivityResult> observeConnectivity();
  Future<ConnectivityResult> getCurrentConnectivity();
}