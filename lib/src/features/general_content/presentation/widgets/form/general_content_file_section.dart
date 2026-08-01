import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/file_upload/dotted_file_picker_box.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/file_upload/selected_file_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class GeneralContentFileSection extends StatelessWidget {
  const GeneralContentFileSection({
    super.key,
    required this.onPickFile,
    required this.onRemoveFile,
    required this.isEditMode,
    this.fileName,
    this.previewBytes,
    this.isImage = false,
    this.showRequiredError = false,
  });

  final VoidCallback onPickFile;
  final VoidCallback onRemoveFile;
  final bool isEditMode;
  final String? fileName;
  final Uint8List? previewBytes;
  final bool isImage;
  final bool showRequiredError;

  bool get hasFile => fileName?.trim().isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FormSectionContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const GeneralContentSectionHeader(
            title: 'فایل بخشنامه',
            icon: Icons.upload_file_rounded,
          ),
          Space.h20,
          if (!hasFile || isImage)
            DottedFilePickerBox(
              title: 'انتخاب فایل',
              description:
                  'فرمت‌های مجاز: jpeg, png, jpg, zip, pdf\n(حداکثر ۵ مگابایت)',
              onTap: onPickFile,
              selected: hasFile,
              fileName: fileName,
              previewBytes: previewBytes,
              isImage: isImage,
              onRemove: hasFile ? onRemoveFile : null,
              height: 190,
            )
          else
            SelectedFileTile(
              title: fileName!,
              subtitle: 'فایل بخشنامه انتخاب شد',
              icon: Container(
                width: AppSize.s42,
                height: AppSize.s42,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.insert_drive_file_outlined,
                  color: colorScheme.primary,
                  size: AppSize.s24,
                ),
              ),
              onRemove: onRemoveFile,
            ),
          if (showRequiredError) ...[
            Space.h8,
            BodySmallText(
              text: 'انتخاب فایل بخشنامه الزامی است.',
              color: colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ],
          if (isEditMode && !hasFile) ...[
            Space.h8,
            BodySmallText(
              text: 'در صورت انتخاب نکردن فایل جدید، فایل قبلی حفظ می‌شود.',
              color: colorScheme.onTertiaryFixed,
            ),
          ],
        ],
      ),
    );
  }
}
