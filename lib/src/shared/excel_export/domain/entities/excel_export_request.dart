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

    final reversedColumns = columns.reversed.toList(growable: false);

    final headers = <String>[
      ...reversedColumns.map((column) => column.title.trim()),
      if (includeRowNumber) 'ردیف',
    ];

    final widths = <double>[
      ...reversedColumns.map((column) => column.width),
      if (includeRowNumber) 10,
    ];

    final rows = List<List<String>>.generate(
      items.length,
      (index) {
        final item = items[index];
        return <String>[
          ...reversedColumns.map(
            (column) => _normalize(column.valueBuilder(item, index)),
          ),
          if (includeRowNumber) '${index + 1}',
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
    if (normalized.isEmpty || _isTechnicalValue(normalized)) {
      return '---';
    }
    return normalized;
  }

  static bool _isTechnicalValue(String value) {
    if (value.startsWith("Instance of '")) {
      return true;
    }

    // Prevent backend type names such as
    // EKS.Common.SAN.EmdadUnitPersonData from leaking into reports.
    return RegExp(
      r'^[A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*){2,}$',
    ).hasMatch(value);
  }
}
