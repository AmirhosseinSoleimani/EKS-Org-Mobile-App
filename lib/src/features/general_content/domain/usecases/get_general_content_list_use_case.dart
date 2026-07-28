import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/repository/general_content_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetGeneralContentListUseCase
    extends BaseUseCase<ApiResult<GeneralContentPageEntity>,
        GeneralContentFilterParamEntity> {
  GetGeneralContentListUseCase(this._repository);

  final GeneralContentRepository _repository;

  @override
  Future<ApiResult<GeneralContentPageEntity>> call(
    GeneralContentFilterParamEntity param,
  ) {
    return _repository.getByFilter(param);
  }
}
