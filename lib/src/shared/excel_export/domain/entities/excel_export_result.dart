class ExcelExportResult {
  const ExcelExportResult({
    required this.fileName,
    required this.savedPath,
    required this.isBrowserDownload,
  });

  final String fileName;
  final String? savedPath;
  final bool isBrowserDownload;

  String get displayPath {
    final path = savedPath?.trim();
    return path?.isNotEmpty == true ? path! : fileName;
  }
}
