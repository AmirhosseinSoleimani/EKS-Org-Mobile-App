import 'package:eks_sana_plus_org/src/shared/features/observe_network/domain/entity/network_state.dart';

abstract interface class ObserveNetworkRepository {
  Stream<NetworkStatus> observe();
  Future<NetworkStatus> current();
}