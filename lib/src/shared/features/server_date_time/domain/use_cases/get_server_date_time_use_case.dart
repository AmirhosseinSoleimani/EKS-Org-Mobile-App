import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/domain/entities/date_time_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/domain/repositories/date_time_info_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetServerDateTimeUseCase
    extends BaseUseCaseNoArgs<ApiResult<DateTimeEntity?>> {
  GetServerDateTimeUseCase(this._repository);

  final DateTimeInfoRepository _repository;

  @override
  Future<ApiResult<DateTimeEntity?>> call() async {
    return await _repository.getServerDateTime();
  }
}
