import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDefectsListUseCase
    extends BaseUseCase<ApiResult<List<DefectEntity>>, int?> {
  EvaluationRepository evaluationRepository;

  GetDefectsListUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<List<DefectEntity>>> call(int? arg) async {
    return await evaluationRepository.getDefectsList(arg);
  }
}
