class ExcelExportResultEntity {
  const ExcelExportResultEntity({
    required this.fileName,
    this.savedPath,
  });

  final String fileName;
  final String? savedPath;
}
