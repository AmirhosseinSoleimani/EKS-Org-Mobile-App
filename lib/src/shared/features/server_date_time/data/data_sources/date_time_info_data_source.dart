import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/data/models/date_time_model.dart';

abstract class DateTimeInfoDataSource {
  Future<BaseSingleResponse<DateTimeModel?>> getServerDateTime();
}
