import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eks_sana_plus_org/src/shared/features/observe_network/data/data_source/observe_network_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/observe_network/domain/entity/network_state.dart';
import 'package:eks_sana_plus_org/src/shared/features/observe_network/domain/entity/network_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/observe_network/domain/repository/observe_network_respository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ObserveNetworkRepository)
class ObserveNetworkRepositoryImpl implements ObserveNetworkRepository {
  final ObserveNetworkDataSource _dataSource;
  ObserveNetworkRepositoryImpl(this._dataSource);
  @override
  Future<NetworkStatus> current() async => _map(await _dataSource.getCurrentConnectivity());

  @override
  Stream<NetworkStatus> observe() => _dataSource.observeConnectivity().map(_map);

  NetworkStatus _map(ConnectivityResult r) {
    switch (r) {
      case ConnectivityResult.wifi:
        return const NetworkStatus(NetworkType.wifi);
      case ConnectivityResult.mobile:
        return const NetworkStatus(NetworkType.mobile);
      case ConnectivityResult.ethernet:
        return const NetworkStatus(NetworkType.ethernet);
      case ConnectivityResult.vpn:
        return const NetworkStatus(NetworkType.vpn);
      case ConnectivityResult.none:
        return const NetworkStatus(NetworkType.none);
      default:
        return const NetworkStatus(NetworkType.other);
    }
  }

}
