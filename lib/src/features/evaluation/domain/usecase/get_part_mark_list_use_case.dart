import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/labor_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_marks_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPartMarkListUseCase
    extends BaseUseCase<ApiResult<List<PartMarkEntity>>, PartMarksParamEntity> {
  EvaluationRepository evaluationRepository;

  GetPartMarkListUseCase(this.evaluationRepository);

  @override
  Future<ApiResult<List<PartMarkEntity>>> call(PartMarksParamEntity arg) async {
    return await evaluationRepository.getPartMarks(arg);
  }
}
