import 'dart:io';

import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:path_provider/path_provider.dart';

class VehicleInfoExcelExporter {
  const VehicleInfoExcelExporter._();

  static Future<String> export(List<VehicleInfoEntity> items) async {
    Directory? directory;
    try {
      directory = await getDownloadsDirectory();
    } catch (_) {
      directory = null;
    }

    directory ??= await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('.', '-');
    final file = File('${directory.path}/vehicle-info-report-$timestamp.xls');
    await file.writeAsString(_buildWorkbook(items), flush: true);
    return file.path;
  }

  static String _buildWorkbook(List<VehicleInfoEntity> items) {
    final rows = items.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final item = entry.value;
      return _tr([
        index.toString(),
        item.id?.toString(),
        item.vehicleModelTitle,
        item.licensePlate,
        item.chassisNumber,
        item.engineNumber,
        item.productYear,
        item.imeiSerial,
        item.installTypeDateJalali ?? item.installTypeDate,
        item.isTroubleShooter == true ? 'دارد' : 'ندارد',
        item.isDepotEnabled == true ? 'فعال' : 'غیرفعال',
        item.tashimTypeTitle,
        item.vehicleStatusTitle ?? (item.isActive == true ? 'فعال' : 'غیرفعال'),
        item.insertUserFullName,
        item.insertDateTimeJalali,
        item.updateUserFullName,
        item.updateDateTimeJalali,
      ]);
    }).join();

    return '''
<html xmlns:o="urn:schemas-microsoft-com:office:office"
      xmlns:x="urn:schemas-microsoft-com:office:excel"
      xmlns="http://www.w3.org/TR/REC-html40">
<head>
  <meta charset="utf-8">
  <!--[if gte mso 9]>
  <xml>
    <x:ExcelWorkbook>
      <x:ExcelWorksheets>
        <x:ExcelWorksheet>
          <x:Name>گزارش خودروها</x:Name>
          <x:WorksheetOptions>
            <x:DisplayRightToLeft/>
          </x:WorksheetOptions>
        </x:ExcelWorksheet>
      </x:ExcelWorksheets>
    </x:ExcelWorkbook>
  </xml>
  <![endif]-->
  <style>
    body { direction: rtl; font-family: Tahoma, Arial, sans-serif; }
    table { border-collapse: collapse; direction: rtl; }
    th, td { border: 1px solid #999; padding: 6px 10px; white-space: nowrap; }
    th { background: #e8eef8; font-weight: bold; }
  </style>
</head>
<body>
  <table>
    <thead>
      ${_tr([
        'ردیف',
        'شناسه خودرو',
        'نوع خودرو',
        'پلاک',
        'شاسی',
        'شماره موتور',
        'سال ساخت',
        'سریال IMEI',
        'تاریخ نصب IMEI',
        'دستگاه عیب یاب',
        'انبارک',
        'مدل تسهیم انبارک',
        'وضعیت',
        'نام ثبت کننده',
        'تاریخ و زمان ثبت',
        'نام ویرایش کننده',
        'تاریخ و زمان ویرایش',
      ], header: true)}
    </thead>
    <tbody>
      $rows
    </tbody>
  </table>
</body>
</html>
''';
  }

  static String _tr(List<String?> values, {bool header = false}) {
    final tag = header ? 'th' : 'td';
    final cells = values.map((value) => '<$tag>${_escape(value)}</$tag>').join();
    return '<tr>$cells</tr>';
  }

  static String _escape(String? value) {
    return (value == null || value.trim().isEmpty ? '---' : value)
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;');
  }
}
