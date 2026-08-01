import 'package:eks_sana_plus_org/src/shared/features/upload_file/data/data_sources/upload_file_data_source.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UploadFileDataSource)
class UploadFileDataSourceImpl implements UploadFileDataSource {
  @override
  Future<PlatformFile?> pickFile({
    required List<String> allowedExtensions,
  }) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      allowMultiple: false,
      withData: true,
    );

    final files = result?.files;
    if (files == null || files.isEmpty) return null;
    return files.first;
  }
}
