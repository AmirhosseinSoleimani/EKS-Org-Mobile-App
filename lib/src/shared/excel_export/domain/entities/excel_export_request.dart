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
    if (columns.isEmpty) {
      throw ArgumentError.value(columns, 'columns', 'حداقل یک ستون لازم است.');
    }

    final headers = <String>[
      if (includeRowNumber) 'ردیف',
      ...columns.map((column) => column.title.trim()),
    ];

    final widths = <double>[
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
            (column) => _normalize(column.valueBuilder(item, index)),
          ),
        ];
      },
      growable: false,
    );

    return ExcelExportRequest._(
      fileNamePrefix: _requiredText(fileNamePrefix, 'fileNamePrefix'),
      sheetName: _requiredText(sheetName, 'sheetName'),
      headers: List<String>.unmodifiable(headers),
      rows: List<List<String>>.unmodifiable(
        rows.map((row) => List<String>.unmodifiable(row)),
      ),
      columnWidths: List<double>.unmodifiable(widths),
      isRtl: isRtl,
    );
  }

  final String fileNamePrefix;
  final String sheetName;
  final List<String> headers;
  final List<List<String>> rows;
  final List<double> columnWidths;
  final bool isRtl;

  static String _requiredText(String value, String fieldName) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw ArgumentError.value(value, fieldName, 'مقدار نمی‌تواند خالی باشد.');
    }
    return normalized;
  }

  static String _normalize(Object? value) {
    if (value == null) return '---';
    if (value is bool) return value ? 'بله' : 'خیر';
    if (value is DateTime) return value.toIso8601String();

    final normalized = value.toString().trim();
    return normalized.isEmpty ? '---' : normalized;
  }
}
