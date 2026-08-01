import 'dart:typed_data';

class UploadedFileEntity {
  const UploadedFileEntity({
    required this.name,
    required this.extension,
    required this.size,
    required this.bytes,
    required this.mimeType,
    required this.dataUri,
    this.path,
  });

  final String name;
  final String extension;
  final int size;
  final Uint8List bytes;
  final String mimeType;
  final String dataUri;
  final String? path;

  bool get isImage {
    return extension == 'png' || extension == 'jpg' || extension == 'jpeg';
  }

  String get sizeText {
    if (size < 1024 * 1024) {
      return '${(size / 1024).toStringAsFixed(0)} KB';
    }
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
