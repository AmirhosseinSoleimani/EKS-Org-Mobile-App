import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/features/upload_file/upload_file.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:flutter/material.dart';

class GeneralContentFileSection extends StatelessWidget {
  const GeneralContentFileSection({
    super.key,
    required this.onFileChanged,
    required this.isEditMode,
  });

  final ValueChanged<UploadedFileEntity?> onFileChanged;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
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
          UploadFileField(
            type: UploadFileType.attachment,
            isRequired: !isEditMode,
            requiredMessage: 'انتخاب فایل بخشنامه الزامی است.',
            selectedFileSubtitle: 'فایل بخشنامه انتخاب شد',
            helperText: isEditMode
                ? 'در صورت انتخاب نکردن فایل جدید، فایل قبلی حفظ می‌شود.'
                : null,
            onChanged: onFileChanged,
          ),
        ],
      ),
    );
  }
}
