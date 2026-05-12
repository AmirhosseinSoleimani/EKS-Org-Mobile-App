

import 'package:eks_sana_plus_org/src/features/services/domain/entities/day_schedule_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_times_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTimesUseCase extends BaseUseCase<
    ApiResult<List<DayScheduleEntity>>, GetTimesParamEntity> {
  RequestRepository requestRepository;

  GetTimesUseCase(this.requestRepository);

  @override
  Future<ApiResult<List<DayScheduleEntity>>> call(arg) async {
    return await requestRepository.getTimes(arg);

  }
}
