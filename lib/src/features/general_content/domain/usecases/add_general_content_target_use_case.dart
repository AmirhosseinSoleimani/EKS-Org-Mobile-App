import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_target_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_target_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/repository/general_content_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddGeneralContentTargetUseCase
    extends BaseUseCase<ApiResult<GeneralContentTargetEntity>,
        GeneralContentTargetParamEntity> {
  AddGeneralContentTargetUseCase(this._repository);

  final GeneralContentRepository _repository;

  @override
  Future<ApiResult<GeneralContentTargetEntity>> call(
    GeneralContentTargetParamEntity param,
  ) {
    return _repository.addTarget(param);
  }
}
