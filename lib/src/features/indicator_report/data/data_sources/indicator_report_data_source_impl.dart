import 'package:dio/dio.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/data/data_sources/indicator_report_data_source.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/indicatior_report_model.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/report_param_model.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/data/service/indicator_report_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IndicatorReportDataSource)
class IndicatorReportDataSourceImpl extends IndicatorReportDataSource {
  IndicatorReportDataSourceImpl(this._service);

  final IndicatorReportService _service;
  CancelToken? _activeRequestToken;

  @override
  Future<BaseSingleResponse<IndicatorReportModel?>> fetchIndicatorReport(
    ReportParamModel param,
  ) async {
    _activeRequestToken?.cancel('Superseded by a newer indicator report request');

    final requestToken = CancelToken();
    _activeRequestToken = requestToken;

    try {
      return await _service.fetchReportList(param.toJson(), requestToken);
    } finally {
      if (identical(_activeRequestToken, requestToken)) {
        _activeRequestToken = null;
      }
    }
  }
}
