import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/data/models/date_time_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/data/service/date_time_service.dart';
import 'package:injectable/injectable.dart';

import 'date_time_info_data_source.dart';

@LazySingleton(as: DateTimeInfoDataSource)
class DateTimeInfoDataSourceImpl extends DateTimeInfoDataSource {
  final DateTimeService _service;

  DateTimeInfoDataSourceImpl(this._service);

  @override
  Future<BaseSingleResponse<DateTimeModel?>> getServerDateTime() async =>
      await _service.getServerDateTime({});
}
