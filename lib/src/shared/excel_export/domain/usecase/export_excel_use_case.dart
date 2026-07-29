import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/repository/excel_export_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ExportExcelUseCase extends BaseUseCase<
    ApiResult<ExcelExportResult>, ExcelExportRequest> {
  ExportExcelUseCase(this._repository);

  final ExcelExportRepository _repository;

  @override
  Future<ApiResult<ExcelExportResult>> call(ExcelExportRequest arg) {
    return _repository.export(arg);
  }
}
