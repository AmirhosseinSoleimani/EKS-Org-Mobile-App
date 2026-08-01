import 'package:file_picker/file_picker.dart';

abstract class UploadFileDataSource {
  Future<PlatformFile?> pickFile({required List<String> allowedExtensions});
}
