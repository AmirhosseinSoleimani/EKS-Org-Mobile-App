import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/entities/uploaded_file_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/domain/enums/upload_file_type.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/presentation/cubit/upload_file_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/presentation/cubit/upload_file_state.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/presentation/widgets/dotted_file_picker_box.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/presentation/widgets/selected_file_tile.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadFileField extends StatelessWidget {
  const UploadFileField({
    super.key,
    required this.type,
    required this.onChanged,
    this.isRequired = false,
    this.requiredMessage = 'انتخاب فایل الزامی است.',
    this.title = 'انتخاب فایل',
    this.description,
    this.selectedFileSubtitle,
    this.helperText,
    this.initialFile,
    this.height = 190,
    this.icon = Icons.upload_file_outlined,
  });

  final UploadFileType type;
  final ValueChanged<UploadedFileEntity?> onChanged;
  final bool isRequired;
  final String requiredMessage;
  final String title;
  final String? description;
  final String? selectedFileSubtitle;
  final String? helperText;
  final UploadedFileEntity? initialFile;
  final double height;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UploadFileCubit>(),
      child: _UploadFileFieldView(
        type: type,
        onChanged: onChanged,
        isRequired: isRequired,
        requiredMessage: requiredMessage,
        title: title,
        description: description,
        selectedFileSubtitle: selectedFileSubtitle,
        helperText: helperText,
        initialFile: initialFile,
        height: height,
        icon: icon,
      ),
    );
  }
}

class _UploadFileFieldView extends StatelessWidget {
  const _UploadFileFieldView({
    required this.type,
    required this.onChanged,
    required this.isRequired,
    required this.requiredMessage,
    required this.title,
    required this.height,
    required this.icon,
    this.description,
    this.selectedFileSubtitle,
    this.helperText,
    this.initialFile,
  });

  final UploadFileType type;
  final ValueChanged<UploadedFileEntity?> onChanged;
  final bool isRequired;
  final String requiredMessage;
  final String title;
  final String? description;
  final String? selectedFileSubtitle;
  final String? helperText;
  final UploadedFileEntity? initialFile;
  final double height;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FormField<UploadedFileEntity>(
      initialValue: initialFile,
      validator: (file) {
        if (isRequired && file == null) return requiredMessage;
        return null;
      },
      builder: (field) {
        return MultiBlocListener(
          listeners: [
            BlocListener<UploadFileCubit, UploadFileState>(
              listenWhen: (previous, current) {
                return current.errorMessage?.trim().isNotEmpty == true &&
                    previous.errorMessage != current.errorMessage;
              },
              listener: (context, state) {
                SnakeBarWidget.showError(
                  context: context,
                  message: state.errorMessage!,
                );
              },
            ),
            BlocListener<UploadFileCubit, UploadFileState>(
              listenWhen: (previous, current) {
                return previous.version != current.version;
              },
              listener: (context, state) {
                field.didChange(state.selectedFile);
                onChanged(state.selectedFile);
              },
            ),
          ],
          child: BlocBuilder<UploadFileCubit, UploadFileState>(
            builder: (context, state) {
              final selectedFile = state.selectedFile ?? field.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (selectedFile == null || selectedFile.isImage)
                    DottedFilePickerBox(
                      title: title,
                      description: description ?? type.pickerDescription,
                      selected: selectedFile != null,
                      isLoading: state.isPicking,
                      fileName: selectedFile?.name,
                      previewBytes: selectedFile?.bytes,
                      isImage: selectedFile?.isImage ?? false,
                      icon: selectedFile == null
                          ? icon
                          : _fileIcon(selectedFile.extension),
                      height: height,
                      onRemove: selectedFile == null
                          ? null
                          : context.read<UploadFileCubit>().clearFile,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.read<UploadFileCubit>().pickFile(type);
                      },
                    )
                  else
                    SelectedFileTile(
                      title: selectedFile.name,
                      subtitle: selectedFileSubtitle ?? selectedFile.sizeText,
                      icon: _FileIcon(extension: selectedFile.extension),
                      onRemove: context.read<UploadFileCubit>().clearFile,
                    ),
                  if (field.hasError) ...[
                    Space.h8,
                    BodySmallText(
                      text: field.errorText ?? '',
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                  if (helperText?.trim().isNotEmpty == true) ...[
                    Space.h8,
                    BodySmallText(
                      text: helperText!,
                      color: Theme.of(context).colorScheme.onTertiaryFixed,
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }

  IconData _fileIcon(String extension) {
    return switch (extension) {
      'pdf' => Icons.picture_as_pdf_outlined,
      'zip' => Icons.folder_zip_outlined,
      'doc' || 'docx' => Icons.description_outlined,
      'png' || 'jpg' || 'jpeg' => Icons.image_outlined,
      _ => Icons.insert_drive_file_outlined,
    };
  }
}

class _FileIcon extends StatelessWidget {
  const _FileIcon({required this.extension});

  final String extension;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final icon = switch (extension) {
      'pdf' => Icons.picture_as_pdf_outlined,
      'zip' => Icons.folder_zip_outlined,
      'doc' || 'docx' => Icons.description_outlined,
      'png' || 'jpg' || 'jpeg' => Icons.image_outlined,
      _ => Icons.insert_drive_file_outlined,
    };

    return Container(
      width: AppSize.s42,
      height: AppSize.s42,
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.10),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: colorScheme.primary, size: AppSize.s24),
    );
  }
}
