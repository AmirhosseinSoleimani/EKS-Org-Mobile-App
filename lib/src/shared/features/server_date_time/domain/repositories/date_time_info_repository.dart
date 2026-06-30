import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/domain/entities/date_time_entity.dart';

abstract class DateTimeInfoRepository {

  Future<ApiResult<DateTimeEntity?>> getServerDateTime();
}
