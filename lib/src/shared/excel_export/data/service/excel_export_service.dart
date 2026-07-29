import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_result_entity.dart';
import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ExcelExportService {
  Future<ExcelExportResultEntity> export(
    ExcelExportRequest request,
  ) async {
    if (request.rows.isEmpty) {
      throw StateError('هیچ داده‌ای برای تهیه گزارش وجود ندارد.');
    }
    if (request.headers.isEmpty) {
      throw StateError('ستون‌های گزارش مشخص نشده‌اند.');
    }

    final workbook = _buildWorkbook(request);
    final encodedBytes = workbook.save();
    if (encodedBytes == null || encodedBytes.isEmpty) {
      throw StateError('ساخت فایل اکسل با خطا مواجه شد.');
    }

    final fileName = _buildFileName(request.fileNamePrefix);
    final savedPath = await FileSaver.instance.saveFile(
      name: fileName,
      bytes: Uint8List.fromList(encodedBytes),
      fileExtension: 'xlsx',
      mimeType: MimeType.microsoftExcel,
    );

    return ExcelExportResultEntity(
      fileName: '$fileName.xlsx',
      savedPath: savedPath.toString(),
    );
  }

  Excel _buildWorkbook(ExcelExportRequest request) {
    final workbook = Excel.createExcel();
    final safeSheetName = _safeSheetName(request.sheetName);
    workbook.rename('Sheet1', safeSheetName);
    workbook.setDefaultSheet(safeSheetName);

    final sheet = workbook[safeSheetName]..isRTL = request.isRtl;
    sheet.appendRow(
      request.headers
          .map<CellValue>((value) => TextCellValue(value))
          .toList(growable: false),
    );

    final headerStyle = CellStyle(
      bold: true,
      textWrapping: TextWrapping.WrapText,
    );
    for (var columnIndex = 0;
        columnIndex < request.headers.length;
        columnIndex++) {
      sheet
          .cell(
            CellIndex.indexByColumnRow(
              columnIndex: columnIndex,
              rowIndex: 0,
            ),
          )
          .cellStyle = headerStyle;

      if (columnIndex < request.columnWidths.length) {
        sheet.setColumnWidth(
          columnIndex,
          request.columnWidths[columnIndex],
        );
      }
    }

    final bodyStyle = CellStyle(textWrapping: TextWrapping.WrapText);
    for (var rowIndex = 0; rowIndex < request.rows.length; rowIndex++) {
      final row = request.rows[rowIndex];
      sheet.appendRow(
        row
            .map<CellValue>((value) => TextCellValue(value))
            .toList(growable: false),
      );
      for (var columnIndex = 0;
          columnIndex < request.headers.length;
          columnIndex++) {
        sheet
            .cell(
              CellIndex.indexByColumnRow(
                columnIndex: columnIndex,
                rowIndex: rowIndex + 1,
              ),
            )
            .cellStyle = bodyStyle;
      }
    }

    return workbook;
  }

  String _safeSheetName(String value) {
    final normalized = value
        .replaceAll(RegExp(r'[\\/:?*\[\]]'), ' ')
        .trim();
    if (normalized.isEmpty) return 'گزارش';
    return normalized.length <= 31
        ? normalized
        : normalized.substring(0, 31);
  }

  String _buildFileName(String prefix) {
    final now = DateTime.now();
    final safePrefix = prefix.isEmpty ? 'report' : prefix;
    final timestamp = '${now.year}'
        '${_twoDigits(now.month)}'
        '${_twoDigits(now.day)}_'
        '${_twoDigits(now.hour)}'
        '${_twoDigits(now.minute)}'
        '${_twoDigits(now.second)}';
    return '${safePrefix}_$timestamp';
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');
}
