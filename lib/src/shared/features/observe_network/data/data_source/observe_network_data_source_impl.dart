import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eks_sana_plus_org/src/shared/features/observe_network/data/service/observe_network_service.dart';
import 'package:injectable/injectable.dart';
import 'observe_network_data_source.dart';

@LazySingleton(as: ObserveNetworkDataSource)
class ObserveNetworkDataSourceImpl implements ObserveNetworkDataSource {
  final ConnectivityService _service;

  ObserveNetworkDataSourceImpl(this._service);

  @override
  Future<ConnectivityResult> getCurrentConnectivity() async => _collapse(await _service.currentRaw());

  @override
  Stream<ConnectivityResult> observeConnectivity() => _service.observeRaw().map(_collapse);


  ConnectivityResult _collapse(List<ConnectivityResult> list) {
    if (list.isEmpty) return ConnectivityResult.none;
    final base = list.where((e) => e != ConnectivityResult.vpn).toList();
    final newList = base.isEmpty ? list : base;
    if (newList.contains(ConnectivityResult.wifi)) return ConnectivityResult.wifi;
    if (newList.contains(ConnectivityResult.ethernet)) return ConnectivityResult.ethernet;
    if (newList.contains(ConnectivityResult.mobile)) return ConnectivityResult.mobile;
    if (newList.contains(ConnectivityResult.bluetooth)) return ConnectivityResult.bluetooth;
    if (newList.contains(ConnectivityResult.other)) return ConnectivityResult.other;
    if (newList.contains(ConnectivityResult.none)) return ConnectivityResult.none;
    return ConnectivityResult.other;
  }

}