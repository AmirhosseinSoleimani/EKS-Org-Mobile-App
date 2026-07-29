import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_column.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';

class RescuerExcelReportFactory {
  const RescuerExcelReportFactory._();

  static ExcelExportRequest create(List<RescuerEntity> items) {
    return ExcelExportRequest.fromItems<RescuerEntity>(
      fileNamePrefix: 'rescuer_report',
      sheetName: 'گزارش امدادرسان‌ها',
      items: items,
      columns: [
        ExcelExportColumn(title: 'شناسه', valueBuilder: (item, _) => item.id, width: 12),
        ExcelExportColumn(title: 'کد پرسنلی', valueBuilder: (item, _) => item.code, width: 16),
        ExcelExportColumn(title: 'نام و نام خانوادگی', valueBuilder: (item, _) => item.fullName, width: 26),
        ExcelExportColumn(title: 'کد ملی', valueBuilder: (item, _) => item.nationalNumber, width: 18),
        ExcelExportColumn(title: 'نام پدر', valueBuilder: (item, _) => item.fatherName, width: 18),
        ExcelExportColumn(title: 'تاریخ تولد', valueBuilder: (item, _) => item.birthDateJalali ?? item.birthDate, width: 18),
        ExcelExportColumn(title: 'محل تولد', valueBuilder: (item, _) => item.cityNamePlaceOfBirth, width: 20),
        ExcelExportColumn(title: 'مدرک تحصیلی', valueBuilder: (item, _) => item.degreeTitle, width: 20),
        ExcelExportColumn(title: 'وضعیت تاهل', valueBuilder: (item, _) => item.maritalTitle, width: 16),
        ExcelExportColumn(title: 'شماره تلفن', valueBuilder: (item, _) => item.tel, width: 18),
        ExcelExportColumn(title: 'شماره موبایل', valueBuilder: (item, _) => item.mobile, width: 18),
        ExcelExportColumn(title: 'استان صدور', valueBuilder: (item, _) => item.provinceNameIssuingPlace, width: 18),
        ExcelExportColumn(title: 'شهر صدور', valueBuilder: (item, _) => item.cityNameIssuingPlace, width: 18),
        ExcelExportColumn(title: 'کد گواهینامه', valueBuilder: (item, _) => item.licenseCode, width: 18),
        ExcelExportColumn(title: 'گواهینامه‌های مهارت', valueBuilder: (item, _) => item.certificatesTitle, width: 30),
        ExcelExportColumn(title: 'سایز لباس', valueBuilder: (item, _) => item.clothingSize, width: 14),
        ExcelExportColumn(title: 'سایز کفش', valueBuilder: (item, _) => item.shoesSize, width: 14),
        ExcelExportColumn(title: 'عنوان وضعیت', valueBuilder: (item, _) => item.statusTitle, width: 18),
        ExcelExportColumn(title: 'وضعیت', valueBuilder: (item, _) => item.isActive == true ? 'فعال' : 'غیرفعال', width: 14),
        ExcelExportColumn(title: 'نشانی', valueBuilder: (item, _) => item.address, width: 36),
        ExcelExportColumn(title: 'ثبت‌کننده', valueBuilder: (item, _) => item.insertUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ ثبت', valueBuilder: (item, _) => item.insertDateTimeJalali, width: 22),
        ExcelExportColumn(title: 'ویرایش‌کننده', valueBuilder: (item, _) => item.updateUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ ویرایش', valueBuilder: (item, _) => item.updateDateTimeJalali, width: 22),
      ],
    );
  }
}
