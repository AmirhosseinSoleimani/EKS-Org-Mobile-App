import 'package:eks_sana_plus_org/src/shared/excel_export/domain/entities/excel_export_request.dart';
import 'package:excel/excel.dart';

class ExcelWorkbookBuilder {
  const ExcelWorkbookBuilder();

  List<int> build(
    ExcelExportRequest request, {
    required String webFileName,
  }) {
    final workbook = Excel.createExcel();
    final sheetName = _sanitizeSheetName(request.sheetName);
    final defaultSheet = workbook.getDefaultSheet();

    if (defaultSheet != null && defaultSheet != sheetName) {
      workbook.rename(defaultSheet, sheetName);
    }
    workbook.setDefaultSheet(sheetName);

    final sheet = workbook[sheetName]..isRTL = request.isRtl;
    _appendHeader(sheet, request);
    _appendRows(sheet, request);
    _applyColumnWidths(sheet, request.columnWidths);

    // In Flutter Web, excel.save() starts a browser download by itself.
    // Therefore the repository must not call FileSaver for Web again.
    final bytes = workbook.save(fileName: webFileName);
    if (bytes == null || bytes.isEmpty) {
      throw StateError('ساخت فایل اکسل با خطا مواجه شد.');
    }
    return bytes;
  }

  void _appendHeader(Sheet sheet, ExcelExportRequest request) {
    sheet.appendRow(
      request.headers.map(TextCellValue.new).toList(growable: false),
    );

    final style = CellStyle(
      bold: true,
      textWrapping: TextWrapping.WrapText,
    );

    for (var index = 0; index < request.headers.length; index++) {
      sheet
          .cell(
            CellIndex.indexByColumnRow(
              columnIndex: index,
              rowIndex: 0,
            ),
          )
          .cellStyle = style;
    }
  }

  void _appendRows(Sheet sheet, ExcelExportRequest request) {
    for (final row in request.rows) {
      sheet.appendRow(
        row.map(TextCellValue.new).toList(growable: false),
      );
    }
  }

  void _applyColumnWidths(Sheet sheet, List<double> widths) {
    for (var index = 0; index < widths.length; index++) {
      sheet.setColumnWidth(index, widths[index]);
    }
  }

  String _sanitizeSheetName(String value) {
    final normalized = value
        .replaceAll(RegExp(r'[\\/:?*\[\]]'), ' ')
        .trim();
    if (normalized.isEmpty) return 'گزارش';
    return normalized.length <= 31 ? normalized : normalized.substring(0, 31);
  }
}
