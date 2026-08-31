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
      includeRowNumber: false,
      columns: [
        ExcelExportColumn(title: 'نام', valueBuilder: (item, _) => item.firstName, width: 18),
        ExcelExportColumn(title: 'نام‌خانوادگی', valueBuilder: (item, _) => item.lastName, width: 22),
        ExcelExportColumn(title: 'نام پدر', valueBuilder: (item, _) => item.fatherName, width: 18),
        ExcelExportColumn(title: 'کد ملی', valueBuilder: (item, _) => item.nationalNumber, width: 18),
        ExcelExportColumn(title: 'تاریخ تولد', valueBuilder: (item, _) => item.birthDateJalali, width: 18),
        ExcelExportColumn(title: 'محل تولد', valueBuilder: (item, _) => _location(item.provinceNamePlaceOfBirth, item.cityNamePlaceOfBirth), width: 24),
        ExcelExportColumn(title: 'محل صدور', valueBuilder: (item, _) => _location(item.provinceNameIssuingPlace, item.cityNameIssuingPlace), width: 24),
        ExcelExportColumn(title: 'وضعیت تاهل', valueBuilder: (item, _) => item.maritalTitle, width: 18),
        ExcelExportColumn(title: 'شماره تلفن', valueBuilder: (item, _) => item.tel, width: 18),
        ExcelExportColumn(title: 'شماره موبایل', valueBuilder: (item, _) => item.mobile, width: 18),
        ExcelExportColumn(title: 'استان و شهر محل سکونت', valueBuilder: (item, _) => item.reportValue('cityIdAddress'), width: 26),
        ExcelExportColumn(title: 'آدرس', valueBuilder: (item, _) => item.address, width: 34),
        ExcelExportColumn(title: 'کد پرسنلی', valueBuilder: (item, _) => item.code, width: 18),
        ExcelExportColumn(title: 'تاریخ شروع همکاری', valueBuilder: (item, _) => item.reportValue('cooperationStartDateJalali'), width: 22),
        ExcelExportColumn(title: 'وضعیت', valueBuilder: (item, _) => _isTruthy(item.status) ? 'فعال' : 'غیر فعال', width: 16),
        ExcelExportColumn(title: 'مدرک تحصیلی', valueBuilder: (item, _) => item.degreeTitle, width: 20),
        ExcelExportColumn(title: 'رشته', valueBuilder: (item, _) => item.reportValue('fieldGraduation'), width: 22),
        ExcelExportColumn(title: 'لباس', valueBuilder: (item, _) => item.clothingSize, width: 14),
        ExcelExportColumn(title: 'کفش', valueBuilder: (item, _) => item.shoesSize, width: 14),
        ExcelExportColumn(title: 'تاریخ اعتبار کارت شناسایی', valueBuilder: (item, _) => item.licenseCode, width: 26),
        ExcelExportColumn(title: "'گواهینامهای مهارت'", valueBuilder: (item, _) => item.certificatesTitle, width: 28),
        ExcelExportColumn(title: 'نام ثبت کننده', valueBuilder: (item, _) => item.insertUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ثبت', valueBuilder: (item, _) => item.insertDateTimeJalali, width: 22),
        ExcelExportColumn(title: 'نام ویرایش کننده', valueBuilder: (item, _) => item.updateUserFullName, width: 22),
        ExcelExportColumn(title: 'تاریخ و زمان ویرایش', valueBuilder: (item, _) => item.updateDateTimeJalali, width: 22),
      ],
    );
  }

  static String? _location(String? province, String? city) {
    if (province?.trim().isNotEmpty == true && city?.trim().isNotEmpty == true) {
      return '${province!.trim()}/${city!.trim()}';
    }
    return null;
  }

  static bool _isTruthy(Object? value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      return normalized.isNotEmpty && normalized != '0' && normalized != 'false';
    }
    return false;
  }
}
