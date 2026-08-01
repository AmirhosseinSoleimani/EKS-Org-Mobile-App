import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

import 'general_content_dropdown_field.dart';
import 'general_content_responsive_field_row.dart';
import 'general_content_section_header.dart';

class GeneralContentMainInfoSection extends StatelessWidget {
  const GeneralContentMainInfoSection({
    super.key,
    required this.titleController,
    required this.contentTypes,
    required this.receiverTypes,
    required this.selectedContentType,
    required this.selectedReceiverType,
    required this.selectedStatus,
    required this.onContentTypeChanged,
    required this.onReceiverTypeChanged,
    required this.onStatusChanged,
  });

  final TextEditingController titleController;
  final List<CurrentSessionEnumItemEntity> contentTypes;
  final List<CurrentSessionEnumItemEntity> receiverTypes;
  final int? selectedContentType;
  final int? selectedReceiverType;
  final int? selectedStatus;
  final ValueChanged<int?> onContentTypeChanged;
  final ValueChanged<int?> onReceiverTypeChanged;
  final ValueChanged<int?> onStatusChanged;

  static const _statusOptions = <CurrentSessionEnumItemEntity>[
    CurrentSessionEnumItemEntity(value: 1, title: 'فعال'),
    CurrentSessionEnumItemEntity(value: 0, title: 'غیرفعال'),
  ];

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const GeneralContentSectionHeader(
            title: 'اطلاعات اصلی',
            icon: Icons.info_rounded,
          ),
          Space.h20,
          TextFormFieldWidget(
            controller: titleController,
            labelText: 'عنوان',
            mandatory: true,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return 'وارد کردن عنوان الزامی است.';
              }
              return null;
            },
          ),
          Space.h16,
          GeneralContentResponsiveFieldRow(
            first: GeneralContentDropdownField(
              label: 'نوع بخشنامه',
              items: contentTypes,
              value: selectedContentType,
              mandatory: true,
              onChanged: onContentTypeChanged,
            ),
            second: GeneralContentDropdownField(
              label: 'نوع گیرندگان',
              items: receiverTypes,
              value: selectedReceiverType,
              mandatory: true,
              onChanged: onReceiverTypeChanged,
            ),
          ),
          Space.h16,
          GeneralContentDropdownField(
            label: 'وضعیت',
            items: _statusOptions,
            value: selectedStatus,
            onChanged: onStatusChanged,
          ),
        ],
      ),
    );
  }
}
