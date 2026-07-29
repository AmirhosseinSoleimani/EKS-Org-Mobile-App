typedef ExcelCellValueBuilder<T> = Object? Function(T item, int index);

class ExcelExportColumn<T> {
  const ExcelExportColumn({
    required this.title,
    required this.valueBuilder,
    this.width = 20,
  });

  final String title;
  final ExcelCellValueBuilder<T> valueBuilder;
  final double width;
}
