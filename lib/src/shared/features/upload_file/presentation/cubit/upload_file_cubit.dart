import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/enums/upload_file_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/exceptions/upload_file_exception.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/use_cases/pick_upload_file_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/presentation/cubit/upload_file_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadFileCubit extends Cubit<UploadFileState> {
  UploadFileCubit(this._pickUploadFileUseCase)
      : super(const UploadFileState());

  final PickUploadFileUseCase _pickUploadFileUseCase;

  Future<void> pickFile(UploadFileType type) async {
    if (state.isPicking) return;

    emit(state.copyWith(isPicking: true, clearError: true));
    try {
      final file = await _pickUploadFileUseCase(type);
      if (file == null) {
        emit(state.copyWith(isPicking: false, clearError: true));
        return;
      }

      emit(
        state.copyWith(
          isPicking: false,
          selectedFile: file,
          clearError: true,
          version: state.version + 1,
        ),
      );
    } on UploadFileException catch (error) {
      emit(
        state.copyWith(
          isPicking: false,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isPicking: false,
          errorMessage: 'خطایی هنگام انتخاب فایل رخ داده است.',
        ),
      );
    }
  }

  void clearFile() {
    emit(
      state.copyWith(
        clearSelectedFile: true,
        clearError: true,
        version: state.version + 1,
      ),
    );
  }
}
