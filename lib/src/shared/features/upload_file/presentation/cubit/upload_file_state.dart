import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/entities/uploaded_file_entity.dart';

class UploadFileState {
  const UploadFileState({
    this.isPicking = false,
    this.selectedFile,
    this.errorMessage,
    this.version = 0,
  });

  final bool isPicking;
  final UploadedFileEntity? selectedFile;
  final String? errorMessage;
  final int version;

  UploadFileState copyWith({
    bool? isPicking,
    UploadedFileEntity? selectedFile,
    bool clearSelectedFile = false,
    String? errorMessage,
    bool clearError = false,
    int? version,
  }) {
    return UploadFileState(
      isPicking: isPicking ?? this.isPicking,
      selectedFile:
          clearSelectedFile ? null : selectedFile ?? this.selectedFile,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      version: version ?? this.version,
    );
  }
}
