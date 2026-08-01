import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/entities/uploaded_file_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/enums/upload_file_type.dart';

abstract class UploadFileRepository {
  Future<UploadedFileEntity?> pickFile(UploadFileType type);
}
