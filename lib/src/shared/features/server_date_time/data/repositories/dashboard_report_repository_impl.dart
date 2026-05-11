
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/data/data_sources/date_time_info_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/domain/entities/date_time_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/domain/repositories/date_time_info_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DateTimeInfoRepository)
class DateTimeRepositoryImpl extends DateTimeInfoRepository {
  final DateTimeInfoDataSource _dataSource;

  DateTimeRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<ApiResult<DateTimeEntity?>> getServerDateTime() async {
    try {
      final result = await _dataSource.getServerDateTime();
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
