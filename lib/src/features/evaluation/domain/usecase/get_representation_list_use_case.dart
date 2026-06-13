import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/RepresentationParamEntity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/representation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/repositories/evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRepresentationListUseCase
    extends
        BaseUseCase<
          ApiResult<List<RepresentationEntity>>,
          RepresentationParamEntity
        > {
  EvaluationRepository evaluationRepository;

  GetRepresentationListUseCase(this.evaluationRepository);

  @override
  Future<  ApiResult<List<RepresentationEntity>>> call(RepresentationParamEntity arg) async {
    return await evaluationRepository.getRepresentationList(arg);
  }
}
