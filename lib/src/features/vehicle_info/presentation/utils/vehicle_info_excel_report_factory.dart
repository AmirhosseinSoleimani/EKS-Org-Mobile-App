import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class VehicleInfoExcelReportFactory {
  const VehicleInfoExcelReportFactory._();

  static ExcelExportRequest create(List<VehicleInfoEntity> items) {
    return ExcelExportRequest.fromItems<VehicleInfoEntity>(
      fileNamePrefix: 'vehicle_info_report',
      sheetName: 'گزارش خودروها',
      items: items,
      columns: [
        ExcelExportColumn(title: 'شناسه خودرو', valueBuilder: (item, _) => item.id, width: 14),
        ExcelExportColumn(title: 'نوع خودرو', valueBuilder: (item, _) => item.vehicleModelTitle, width: 22),
        ExcelExportColumn(title: 'پلاک', valueBuilder: (item, _) => item.licensePlate, width: 20),
        ExcelExportColumn(title: 'شاسی', valueBuilder: (item, _) => item.chassisNumber, width: 24),
        ExcelExportColumn(title: 'شماره موتور', valueBuilder: (item, _) => item.engineNumber, width: 20),
        ExcelExportColumn(title: 'سال ساخت', valueBuilder: (item, _) => item.productYear, width: 14),
        ExcelExportColumn(title: 'سریال IMEI', valueBuilder: (item, _) => item.imeiSerial, width: 22),
        ExcelExportColumn(title: 'تاریخ نصب IMEI', valueBuilder: (item, _) => item.installTypeDateJalali ?? item.installTypeDate, width: 20),
        ExcelExportColumn(title: 'دستگاه عیب یاب', valueBuilder: (item, _) => item.isTroubleShooter == true ? 'دارد' : 'ندارد', width: 18),
        ExcelExportColumn(title: 'انبارک', valueBuilder: (item, _) => item.isDepotEnabled == true ? 'فعال' : 'غیرفعال', width: 14),
        ExcelExportColumn(title: 'مدل تسهیم انبارک', valueBuilder: (item, _) => item.tashimTypeTitle, width: 22),
        ExcelExportColumn(title: 'وضعیت', valueBuilder: (item, _) => item.vehicleStatusTitle ?? (item.isActive == true ? 'فعال' : 'غیرفعال'), width: 18),
        ExcelExportColumn(title: 'نام ثبت کننده', valueBuilder: (item, _) => item.insertUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ثبت', valueBuilder: (item, _) => item.insertDateTimeJalali, width: 22),
        ExcelExportColumn(title: 'نام ویرایش کننده', valueBuilder: (item, _) => item.updateUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ویرایش', valueBuilder: (item, _) => item.updateDateTimeJalali, width: 22),
      ],
    );
  }
}
