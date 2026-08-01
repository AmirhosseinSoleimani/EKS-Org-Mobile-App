import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_dropdown_field.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_responsive_field_row.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:flutter/material.dart';

class GeneralContentTargetFormSection extends StatelessWidget {
  const GeneralContentTargetFormSection({
    super.key,
    required this.targetTypes,
    required this.targetCategories,
    required this.boundaryTypes,
    required this.operatorTypes,
    required this.selectedTargetType,
    required this.selectedTargetCategory,
    required this.selectedBoundaryType,
    required this.selectedOperatorType,
    required this.onTargetTypeChanged,
    required this.onTargetCategoryChanged,
    required this.onBoundaryTypeChanged,
    required this.onOperatorTypeChanged,
  });

  final List<CurrentSessionEnumItemEntity> targetTypes;
  final List<CurrentSessionEnumItemEntity> targetCategories;
  final List<CurrentSessionEnumItemEntity> boundaryTypes;
  final List<CurrentSessionEnumItemEntity> operatorTypes;
  final int? selectedTargetType;
  final int? selectedTargetCategory;
  final int? selectedBoundaryType;
  final int? selectedOperatorType;
  final ValueChanged<int?> onTargetTypeChanged;
  final ValueChanged<int?> onTargetCategoryChanged;
  final ValueChanged<int?> onBoundaryTypeChanged;
  final ValueChanged<int?> onOperatorTypeChanged;

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GeneralContentDropdownField(
            label: 'نوع',
            items: targetTypes,
            value: selectedTargetType,
            mandatory: true,
            onChanged: onTargetTypeChanged,
          ),
          Space.h16,
          GeneralContentDropdownField(
            label: 'مقدار',
            items: targetCategories,
            value: selectedTargetCategory,
            mandatory: true,
            onChanged: onTargetCategoryChanged,
          ),
          Space.h16,
          GeneralContentResponsiveFieldRow(
            first: GeneralContentDropdownField(
              label: 'نحوه تأثیر',
              items: boundaryTypes,
              value: selectedBoundaryType,
              mandatory: true,
              onChanged: onBoundaryTypeChanged,
            ),
            second: GeneralContentDropdownField(
              label: 'شرط',
              items: operatorTypes,
              value: selectedOperatorType,
              mandatory: true,
              onChanged: onOperatorTypeChanged,
            ),
          ),
        ],
      ),
    );
  }
}
