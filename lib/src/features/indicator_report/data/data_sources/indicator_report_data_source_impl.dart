import 'package:eks_sana_plus_org/src/features/indicator_report/data/data_sources/indicator_report_data_source.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/indicatior_report_model.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/data/models/report_param_model.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/data/service/indicator_report_service.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IndicatorReportDataSource)
class IndicatorReportDataSourceImpl extends IndicatorReportDataSource {
  final IndicatorReportService _service;

  IndicatorReportDataSourceImpl(this._service);

  @override
  Future<BaseListResponse<IndicatorReportModel?>> fetchReportList(
          ReportParamModel param) async =>
      await _service.fetchReportList(param.toJson());
}
