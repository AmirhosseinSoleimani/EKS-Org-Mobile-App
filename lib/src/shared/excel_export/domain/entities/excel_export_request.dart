import 'excel_export_column.dart';

class ExcelExportRequest {
  const ExcelExportRequest._({
    required this.fileNamePrefix,
    required this.sheetName,
    required this.headers,
    required this.rows,
    required this.columnWidths,
    required this.isRtl,
  });

  static ExcelExportRequest fromItems<T>({
    required String fileNamePrefix,
    required String sheetName,
    required List<T> items,
    required List<ExcelExportColumn<T>> columns,
    bool includeRowNumber = true,
    bool isRtl = true,
  }) {
    final headers = <String>[
      if (includeRowNumber) 'ردیف',
      ...columns.map((column) => column.title),
    ];

    final columnWidths = <double>[
      if (includeRowNumber) 10,
      ...columns.map((column) => column.width),
    ];

    final rows = List<List<String>>.generate(
      items.length,
          (index) {
        final item = items[index];

        return <String>[
          if (includeRowNumber) '${index + 1}',
          ...columns.map(
                (column) => _normalize(
              column.valueBuilder(item, index),
            ),
          ),
        ];
      },
      growable: false,
    );

    return ExcelExportRequest._(
      fileNamePrefix: fileNamePrefix.trim(),
      sheetName: sheetName.trim(),
      headers: List<String>.unmodifiable(headers),
      rows: List<List<String>>.unmodifiable(
        rows.map(
              (row) => List<String>.unmodifiable(row),
        ),
      ),
      columnWidths: List<double>.unmodifiable(columnWidths),
      isRtl: isRtl,
    );
  }

  final String fileNamePrefix;
  final String sheetName;
  final List<String> headers;
  final List<List<String>> rows;
  final List<double> columnWidths;
  final bool isRtl;

  static String _normalize(Object? value) {
    if (value == null) {
      return '';
    }

    if (value is bool) {
      return value ? 'بله' : 'خیر';
    }

    if (value is DateTime) {
      return value.toIso8601String();
    }

    return value.toString().trim();
  }
}