import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class GradePatternExcelReportFactory {
  const GradePatternExcelReportFactory._();

  static ExcelExportRequest create(List<GradePatternEntity> items) {
    return ExcelExportRequest.fromItems<GradePatternEntity>(
      fileNamePrefix: 'grade_pattern_report',
      sheetName: 'گزارش الگوهای گرید',
      items: items,
      columns: [
        ExcelExportColumn(title: 'شناسه', valueBuilder: (item, _) => item.id, width: 12),
        ExcelExportColumn(title: 'کد', valueBuilder: (item, _) => item.code, width: 14),
        ExcelExportColumn(title: 'عنوان الگو', valueBuilder: (item, _) => item.name, width: 28),
        ExcelExportColumn(title: 'تعداد جزئیات', valueBuilder: (item, _) => item.details.length, width: 16),
        ExcelExportColumn(title: 'وضعیت', valueBuilder: (item, _) => item.isActive ? 'فعال' : 'غیرفعال', width: 14),
        ExcelExportColumn(title: 'نام ثبت کننده', valueBuilder: (item, _) => item.insertUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ثبت', valueBuilder: (item, _) => item.insertDateTimeJalali, width: 22),
        ExcelExportColumn(title: 'نام ویرایش کننده', valueBuilder: (item, _) => item.updateUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ویرایش', valueBuilder: (item, _) => item.updateDateTimeJalali, width: 22),
      ],
    );
  }
}
