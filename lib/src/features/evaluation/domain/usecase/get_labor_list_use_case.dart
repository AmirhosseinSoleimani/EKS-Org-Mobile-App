import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/labor_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLaborListUseCase
    extends BaseUseCase<ApiResult<List<LaborEntity>>, LaborListParamEntity> {
  EvaluationRepository evaluationRepository;

  GetLaborListUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<List<LaborEntity>>> call(LaborListParamEntity arg) async {
    return await evaluationRepository.getLaborList(arg);
  }
}
