import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_result.dart';

abstract class ExcelExportRepository {
  Future<ApiResult<ExcelExportResult>> export(ExcelExportRequest request);
}
