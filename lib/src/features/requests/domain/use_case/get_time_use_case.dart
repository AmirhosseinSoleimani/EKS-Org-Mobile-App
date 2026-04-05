import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/get_times_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/time_table_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTimesUseCase extends BaseUseCase<
    ApiResult<List<DayScheduleEntity?>>, GetTimesParam> {
  RequestRepository requestRepository;

  GetTimesUseCase(this.requestRepository);

  @override
  Future<ApiResult<List<DayScheduleEntity?>>> call(arg) async {
    final result = await requestRepository.getTimes(arg);
    return result;
  }
}
