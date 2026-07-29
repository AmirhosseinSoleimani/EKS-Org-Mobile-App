import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class DeploymentLocationExcelReportFactory {
  const DeploymentLocationExcelReportFactory._();

  static ExcelExportRequest create(List<DeploymentLocationEntity> items) {
    return ExcelExportRequest.fromItems<DeploymentLocationEntity>(
      fileNamePrefix: 'deployment_locations_report',
      sheetName: 'محل‌های استقرار',
      items: items,
      columns: [
        ExcelExportColumn(title: 'شناسه', valueBuilder: (item, _) => item.id, width: 12),
        ExcelExportColumn(title: 'عنوان', valueBuilder: (item, _) => item.title, width: 28),
        ExcelExportColumn(title: 'استان', valueBuilder: (item, _) => item.provinceTitle, width: 20),
        ExcelExportColumn(title: 'شناسه استان', valueBuilder: (item, _) => item.provinceId, width: 14),
        ExcelExportColumn(title: 'شهر', valueBuilder: (item, _) => item.cityTitle, width: 20),
        ExcelExportColumn(title: 'شناسه شهر', valueBuilder: (item, _) => item.cityId, width: 14),
        ExcelExportColumn(title: 'آدرس', valueBuilder: (item, _) => item.address, width: 40),
        ExcelExportColumn(title: 'عرض جغرافیایی', valueBuilder: (item, _) => item.latitude, width: 18),
        ExcelExportColumn(title: 'طول جغرافیایی', valueBuilder: (item, _) => item.longitude, width: 18),
        ExcelExportColumn(title: 'وضعیت', valueBuilder: (item, _) => item.isActive == true ? 'فعال' : 'غیرفعال', width: 14),
        ExcelExportColumn(title: 'ثبت‌کننده', valueBuilder: (item, _) => item.insertFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ ثبت', valueBuilder: (item, _) => item.insertDateTimeJalali, width: 22),
        ExcelExportColumn(title: 'ویرایش‌کننده', valueBuilder: (item, _) => item.updateFullName, width: 22),
      ],
    );
  }
}
