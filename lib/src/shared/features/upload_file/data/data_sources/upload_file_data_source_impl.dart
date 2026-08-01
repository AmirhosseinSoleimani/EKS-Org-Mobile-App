import 'package:eks_sana_plus_org/src/shared/features/upload_file/data/data_sources/upload_file_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/data/exceptions/upload_file_picker_exception.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UploadFileDataSource)
class UploadFileDataSourceImpl implements UploadFileDataSource {
  @override
  Future<PlatformFile?> pickFile({required bool imageOnly}) async {
    try {
      final result = await FilePicker.pickFiles(
        type: imageOnly ? FileType.image : FileType.any,
        allowMultiple: false,
        withData: true,
      );

      final files = result?.files;
      if (files == null || files.isEmpty) return null;
      return files.first;
    } on MissingPluginException {
      throw const UploadFilePickerUnavailableException();
    }
  }
}
