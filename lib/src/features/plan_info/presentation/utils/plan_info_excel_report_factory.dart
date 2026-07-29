import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class PlanInfoExcelReportFactory {
  const PlanInfoExcelReportFactory._();

  static ExcelExportRequest create(List<PlanInfoEntity> items) {
    return ExcelExportRequest.fromItems<PlanInfoEntity>(
      fileNamePrefix: 'plan_info_report',
      sheetName: 'گزارش برنامه‌ریزی‌ها',
      items: items,
      columns: [
        ExcelExportColumn(title: 'شناسه برنامه‌ریزی', valueBuilder: (item, _) => item.id ?? item.planId, width: 18),
        ExcelExportColumn(title: 'عنوان', valueBuilder: (item, _) => item.title, width: 28),
        ExcelExportColumn(title: 'واحد امدادی', valueBuilder: (item, _) => item.emdadUnitName, width: 24),
        ExcelExportColumn(title: 'تاریخ شروع', valueBuilder: (item, _) => item.fromDateJalali ?? item.fromDate, width: 18),
        ExcelExportColumn(title: 'تاریخ پایان', valueBuilder: (item, _) => item.toDateJalali ?? item.toDate, width: 18),
        ExcelExportColumn(title: 'عنوان شیفت', valueBuilder: (item, _) => item.shiftTitle, width: 22),
        ExcelExportColumn(title: 'عنوان طرح ویژه', valueBuilder: (item, _) => item.specialPlanTitle, width: 24),
        ExcelExportColumn(title: 'نوع مقر', valueBuilder: (item, _) => item.seatTypeTitle, width: 18),
        ExcelExportColumn(title: 'محل استقرار', valueBuilder: (item, _) => item.locationTitle, width: 24),
        ExcelExportColumn(title: 'عرض جغرافیایی', valueBuilder: (item, _) => item.latitude, width: 18),
        ExcelExportColumn(title: 'طول جغرافیایی', valueBuilder: (item, _) => item.longitude, width: 18),
        ExcelExportColumn(title: 'آدرس محل استقرار', valueBuilder: (item, _) => item.address, width: 36),
        ExcelExportColumn(title: 'وضعیت', valueBuilder: (item, _) => item.isActive ? 'فعال' : 'غیرفعال', width: 14),
        ExcelExportColumn(title: 'دلیل تغییر وضعیت', valueBuilder: (item, _) => item.reasonTitle, width: 24),
        ExcelExportColumn(title: 'توضیحات', valueBuilder: (item, _) => item.description, width: 32),
        ExcelExportColumn(title: 'نام ثبت کننده', valueBuilder: (item, _) => item.insertUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ثبت', valueBuilder: (item, _) => item.insertDateTimeJalali, width: 22),
        ExcelExportColumn(title: 'نام ویرایش کننده', valueBuilder: (item, _) => item.updateUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ویرایش', valueBuilder: (item, _) => item.updateDateTimeJalali, width: 22),
        ExcelExportColumn(title: 'امدادرسان‌ها', valueBuilder: (item, _) => item.personsText, width: 34),
      ],
    );
  }
}
