import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/entities/uploaded_file_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/enums/upload_file_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/repositories/upload_file_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PickUploadFileUseCase {
  const PickUploadFileUseCase(this._repository);

  final UploadFileRepository _repository;

  Future<UploadedFileEntity?> call(UploadFileType type) {
    return _repository.pickFile(type);
  }
}
