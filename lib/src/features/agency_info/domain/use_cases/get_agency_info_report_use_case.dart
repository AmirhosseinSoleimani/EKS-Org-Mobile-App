import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/repositories/agency_info_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAgencyInfoReportUseCase {
  const GetAgencyInfoReportUseCase(this._repository);

  final AgencyInfoRepository _repository;

  Future<ApiResult<AgencyInfoReportEntity>> call(
    AgencyInfoFilterParamEntity param,
  ) {
    return _repository.getReport(param);
  }
}
