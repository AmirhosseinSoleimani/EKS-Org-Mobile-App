class ExcelExportColumn<T> {
  const ExcelExportColumn({
    required this.title,
    required this.valueBuilder,
    this.width = 20,
  });

  final String title;
  final Object? Function(T item, int index) valueBuilder;
  final double width;
}
