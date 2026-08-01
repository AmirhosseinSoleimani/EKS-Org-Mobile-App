import 'dart:convert';

import 'package:eks_sana_plus_org/src/shared/features/upload_file/data/data_sources/upload_file_data_source.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/data/exceptions/upload_file_picker_exception.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/entities/uploaded_file_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/enums/upload_file_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/exceptions/upload_file_exception.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/repositories/upload_file_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UploadFileRepository)
class UploadFileRepositoryImpl implements UploadFileRepository {
  const UploadFileRepositoryImpl(this._dataSource);

  final UploadFileDataSource _dataSource;

  @override
  Future<UploadedFileEntity?> pickFile(UploadFileType type) async {
    try {
      final file = await _dataSource.pickFile(
        imageOnly: type == UploadFileType.image,
      );
      if (file == null) return null;

      if (file.size > type.maxFileSizeInBytes) {
        throw UploadFileException(
          'حجم فایل انتخاب‌شده نباید بیشتر از '
          '${type.maxFileSizeInMegabytes} مگابایت باشد.',
        );
      }

      final extension = _resolveExtension(
        extension: file.extension,
        fileName: file.name,
      );
      if (!type.allowedExtensions.contains(extension)) {
        throw UploadFileException(
          'فرمت فایل انتخاب‌شده مجاز نیست. فرمت‌های مجاز: '
          '${type.allowedExtensionsText}',
        );
      }

      final bytes = file.bytes ?? await file.xFile.readAsBytes();
      if (bytes.isEmpty) {
        throw const UploadFileException(
          'امکان خواندن فایل انتخاب‌شده وجود ندارد.',
        );
      }

      final effectiveSize = file.size > bytes.length ? file.size : bytes.length;
      if (effectiveSize > type.maxFileSizeInBytes) {
        throw UploadFileException(
          'حجم فایل انتخاب‌شده نباید بیشتر از '
          '${type.maxFileSizeInMegabytes} مگابایت باشد.',
        );
      }

      final mimeType = _mimeType(extension);
      return UploadedFileEntity(
        name: file.name,
        extension: extension,
        size: effectiveSize,
        bytes: bytes,
        mimeType: mimeType,
        dataUri: 'data:$mimeType;base64,${base64Encode(bytes)}',
        path: file.path,
      );
    } on UploadFilePickerUnavailableException {
      throw const UploadFileException(
        'انتخاب‌گر فایل در نسخه فعلی برنامه فعال نشده است. '
        'برنامه را کامل ببندید و دوباره اجرا کنید.',
      );
    } on UploadFileException {
      rethrow;
    } catch (_) {
      throw const UploadFileException(
        'خطایی هنگام انتخاب یا خواندن فایل رخ داده است.',
      );
    }
  }

  String _resolveExtension({
    required String? extension,
    required String fileName,
  }) {
    final normalized = extension?.trim().toLowerCase().replaceAll('.', '') ?? '';
    if (normalized.isNotEmpty) return normalized;

    final separatorIndex = fileName.lastIndexOf('.');
    if (separatorIndex < 0 || separatorIndex == fileName.length - 1) return '';
    return fileName.substring(separatorIndex + 1).trim().toLowerCase();
  }

  String _mimeType(String extension) {
    return switch (extension) {
      'png' => 'image/png',
      'jpg' || 'jpeg' => 'image/jpeg',
      'pdf' => 'application/pdf',
      'zip' => 'application/zip',
      'doc' => 'application/msword',
      'docx' =>
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      _ => 'application/octet-stream',
    };
  }
}
