import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';

class DeploymentLocationExcelExporter {
  const DeploymentLocationExcelExporter();

  static const String _sheetName = 'محل‌های استقرار';

  Future<String?> export(List<DeploymentLocationEntity> records) async {
    if (records.isEmpty) {
      throw StateError('هیچ رکوردی برای تهیه گزارش وجود ندارد.');
    }

    final workbook = _createWorkbook(records);
    final encodedBytes = workbook.save();
    if (encodedBytes == null || encodedBytes.isEmpty) {
      throw StateError('ساخت فایل اکسل با خطا مواجه شد.');
    }

    final savedPath = await FileSaver.instance.saveFile(
      name: _buildFileName(),
      bytes: Uint8List.fromList(encodedBytes),
      fileExtension: 'xlsx',
      mimeType: MimeType.microsoftExcel,
    );

    return savedPath.toString();
  }

  Excel _createWorkbook(List<DeploymentLocationEntity> records) {
    final workbook = Excel.createExcel();
    workbook.rename('Sheet1', _sheetName);
    workbook.setDefaultSheet(_sheetName);

    final sheet = workbook[_sheetName]..isRTL = true;
    _appendHeader(sheet);
    _appendRecords(sheet, records);

    return workbook;
  }

  void _appendHeader(Sheet sheet) {
    const headers = [
      'ردیف',
      'شناسه',
      'عنوان',
      'استان',
      'شناسه استان',
      'شهر',
      'شناسه شهر',
      'آدرس',
      'عرض جغرافیایی',
      'طول جغرافیایی',
      'وضعیت',
      'ثبت‌کننده',
      'تاریخ ثبت',
      'ویرایش‌کننده',
    ];

    sheet.appendRow(
      headers
          .map((header) => TextCellValue(header))
          .toList(growable: false),
    );

    final headerStyle = CellStyle(
      bold: true,
      textWrapping: TextWrapping.WrapText,
    );

    for (var columnIndex = 0;
        columnIndex < headers.length;
        columnIndex++) {
      sheet
          .cell(
            CellIndex.indexByColumnRow(
              columnIndex: columnIndex,
              rowIndex: 0,
            ),
          )
          .cellStyle = headerStyle;
    }
  }

  void _appendRecords(
    Sheet sheet,
    List<DeploymentLocationEntity> records,
  ) {
    for (var index = 0; index < records.length; index++) {
      final item = records[index];
      sheet.appendRow([
        TextCellValue('${index + 1}'),
        TextCellValue(_value(item.id)),
        TextCellValue(_value(item.title)),
        TextCellValue(_value(item.provinceTitle)),
        TextCellValue(_value(item.provinceId)),
        TextCellValue(_value(item.cityTitle)),
        TextCellValue(_value(item.cityId)),
        TextCellValue(_value(item.address)),
        TextCellValue(_value(item.latitude)),
        TextCellValue(_value(item.longitude)),
        TextCellValue(item.isActive == true ? 'فعال' : 'غیرفعال'),
        TextCellValue(_value(item.insertFullName)),
        TextCellValue(_value(item.insertDateTimeJalali)),
        TextCellValue(_value(item.updateFullName)),
      ]);
    }
  }

  String _value(Object? value) {
    final result = value?.toString().trim();
    return result == null || result.isEmpty ? '---' : result;
  }

  String _buildFileName() {
    final now = DateTime.now();
    return 'deployment_locations_'
        '${now.year}'
        '${_twoDigits(now.month)}'
        '${_twoDigits(now.day)}_'
        '${_twoDigits(now.hour)}'
        '${_twoDigits(now.minute)}'
        '${_twoDigits(now.second)}';
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');
}
