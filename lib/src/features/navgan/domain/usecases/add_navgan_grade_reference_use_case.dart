import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/params/navgan_grade_reference_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/repository/navgan_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddNavganGradeReferenceUseCase
    extends BaseUseCase<ApiResult<String>, NavganGradeReferenceParamEntity> {
  AddNavganGradeReferenceUseCase(this._repository);

  final NavganRepository _repository;

  @override
  Future<ApiResult<String>> call(NavganGradeReferenceParamEntity arg) {
    return _repository.addGradeReference(arg);
  }
}
