import 'package:eks_sana_plus_org/src/shared/excel_export/data/service/excel_workbook_builder.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ExcelWorkbookBuilderModule {
  @lazySingleton
  ExcelWorkbookBuilder get builder => const ExcelWorkbookBuilder();
}
