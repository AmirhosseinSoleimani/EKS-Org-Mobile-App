class UploadFileException implements Exception {
  const UploadFileException(this.message);

  final String message;

  @override
  String toString() => message;
}
