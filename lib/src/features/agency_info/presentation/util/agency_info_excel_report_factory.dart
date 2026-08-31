import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class AgencyInfoExcelReportFactory {
  const AgencyInfoExcelReportFactory._();

  static ExcelExportRequest create(List<AgencyInfoEntity> items) {
    return ExcelExportRequest.fromItems<AgencyInfoEntity>(
      fileNamePrefix: 'agency_info_report',
      sheetName: 'گزارش نمایندگی‌ها',
      items: items,
      columns: [
        ExcelExportColumn(title: 'کد نمایندگی', valueBuilder: (item, _) => item.code, width: 16),
        ExcelExportColumn(title: 'نام نمایندگی', valueBuilder: (item, _) => item.name, width: 28),
        ExcelExportColumn(title: 'نوع', valueBuilder: (item, _) => item.type, width: 18),
        ExcelExportColumn(title: 'نام‌و‌نام‌خانوادگی مدیر', valueBuilder: (item, _) => item.managerFullName, width: 26),
        ExcelExportColumn(title: 'کد ملی مدیر', valueBuilder: (item, _) => item.nationalNumber, width: 18),
        ExcelExportColumn(title: 'تلفن', valueBuilder: (item, _) => item.telephone, width: 18),
        ExcelExportColumn(title: 'موبایل', valueBuilder: (item, _) => item.mobileNumber, width: 18),
        ExcelExportColumn(title: 'ایمیل', valueBuilder: (item, _) => item.email, width: 26),
        ExcelExportColumn(title: 'فکس', valueBuilder: (item, _) => item.fax, width: 18),
        ExcelExportColumn(title: 'استان', valueBuilder: (item, _) => item.provinceTitle, width: 18),
        ExcelExportColumn(title: 'شهر', valueBuilder: (item, _) => item.cityTitle, width: 18),
        ExcelExportColumn(title: 'آدرس', valueBuilder: (item, _) => item.address, width: 38),
        ExcelExportColumn(title: 'شناسه ملی', valueBuilder: (item, _) => item.agencyNationalId, width: 18),
        ExcelExportColumn(title: 'شماره پیگیری', valueBuilder: (item, _) => item.trackingNumber, width: 18),
        ExcelExportColumn(title: 'پرونده مالیاتی', valueBuilder: (item, _) => item.taxFileCompleted == true ? 'دارد' : 'ندارد', width: 20),
        ExcelExportColumn(title: 'وضعیت', valueBuilder: (item, _) => item.statusTitle, width: 14),
        ExcelExportColumn(title: 'نام ثبت کننده', valueBuilder: (item, _) => item.insertUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ثبت', valueBuilder: (item, _) => item.insertDateTimeJalali, width: 22),
        ExcelExportColumn(title: 'نام ویرایش کننده', valueBuilder: (item, _) => item.updateUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ویرایش', valueBuilder: (item, _) => item.updateDateTimeJalali, width: 22),
      ],
    );
  }
}
