import 'package:eks_sana_plus_org/src/features/services/domain/entities/minimal_customer_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/minimal_customer_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMinimalCustomerInfoUseCase
    extends
        BaseUseCase<
          ApiResult<MinimalCustomerInfoEntity>,
          MinimalCustomerInfoParamEntity
        > {
  final RequestRepository _repository;

  GetMinimalCustomerInfoUseCase(this._repository);

  @override
  Future<ApiResult<MinimalCustomerInfoEntity>> call(arg) async =>
      await _repository.getMinimalCustomerInfo(arg);
}
