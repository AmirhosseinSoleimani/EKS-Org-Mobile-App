import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/data/service/excel_export_service.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_result_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/repository/excel_export_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExcelExportRepository)
class ExcelExportRepositoryImpl extends ExcelExportRepository {
  ExcelExportRepositoryImpl(this._service);

  final ExcelExportService _service;

  @override
  Future<ApiResult<ExcelExportResultEntity>> export(
    ExcelExportRequest request,
  ) async {
    try {
      final result = await _service.export(request);
      return ApiResult<ExcelExportResultEntity>.success(
        resultCode: 0,
        data: result,
        failures: const [],
      );
    } catch (error, stackTrace) {
      return error.toApiResult(stackTrace);
    }
  }
}
