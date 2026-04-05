import 'package:eks_sana_plus_org/src/shared/features/observe_network/domain/entity/network_state.dart';
import 'package:eks_sana_plus_org/src/shared/features/observe_network/domain/repository/observe_network_respository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ObserveNetworkUseCase {
  final ObserveNetworkRepository _repository;
  ObserveNetworkUseCase(this._repository);

  Stream<NetworkStatus> call() => _repository.observe();
}