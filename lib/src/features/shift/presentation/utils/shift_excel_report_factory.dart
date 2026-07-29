import 'package:eks_sana_plus_org/src/features/shift/domain/entities/shift_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class ShiftExcelReportFactory {
  const ShiftExcelReportFactory._();

  static ExcelExportRequest create(List<ShiftEntity> items) {
    return ExcelExportRequest.fromItems<ShiftEntity>(
      fileNamePrefix: 'shift_report',
      sheetName: 'گزارش شیفت‌ها',
      items: items,
      columns: [
        ExcelExportColumn(title: 'عنوان', valueBuilder: (item, _) => item.title, width: 26),
        ExcelExportColumn(title: 'نوع', valueBuilder: (item, _) => item.typeTitle, width: 20),
        ExcelExportColumn(title: 'تاریخ شروع', valueBuilder: (item, _) => item.startDateJalali ?? item.startDate, width: 18),
        ExcelExportColumn(title: 'تاریخ پایان', valueBuilder: (item, _) => item.endDateJalali ?? item.endDate, width: 18),
        ExcelExportColumn(title: 'زمان شروع', valueBuilder: (item, _) => item.startTimeStr ?? item.startTime, width: 16),
        ExcelExportColumn(title: 'زمان پایان', valueBuilder: (item, _) => item.endTimeStr ?? item.endTime, width: 16),
        ExcelExportColumn(title: 'وضعیت', valueBuilder: (item, _) => item.isActive ? 'فعال' : 'غیرفعال', width: 14),
        ExcelExportColumn(title: 'نام ثبت کننده', valueBuilder: (item, _) => item.insertUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ثبت', valueBuilder: (item, _) => item.insertDateTimeJalali, width: 22),
        ExcelExportColumn(title: 'نام ویرایش کننده', valueBuilder: (item, _) => item.updateUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ویرایش', valueBuilder: (item, _) => item.updateDateTimeJalali, width: 22),
      ],
    );
  }
}
