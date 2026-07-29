import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_result_entity.dart';

import '../entities/excel_export_request.dart';

abstract class ExcelExportRepository {
  Future<ApiResult<ExcelExportResultEntity>> export(
    ExcelExportRequest request,
  );
}
