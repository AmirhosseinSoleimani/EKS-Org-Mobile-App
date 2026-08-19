import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/data_sources/dashboard_data_source.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_model.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/models/dashboard_param_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/server_date_time/data/models/date_time_model.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/data/service/dashboard_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DashboardDataSource)
class DashboardDataSourceImpl extends DashboardDataSource {
  DashboardDataSourceImpl(this._service);

  final DashboardService _service;
  CancelToken? _activeRequestToken;

  @override
  Future<BaseSingleResponse<DashboardModel?>> getDashboardData(
    DashboardParamModel param,
  ) async {
    _activeRequestToken?.cancel('Superseded by a newer dashboard request');

    final requestToken = CancelToken();
    _activeRequestToken = requestToken;

    try {
      return await _service.getDashboardData(param.toJson(), requestToken);
    } finally {
      if (identical(_activeRequestToken, requestToken)) {
        _activeRequestToken = null;
      }
    }
  }
}
