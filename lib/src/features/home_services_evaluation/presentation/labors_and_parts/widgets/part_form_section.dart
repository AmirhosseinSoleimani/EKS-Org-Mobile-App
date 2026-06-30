import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/bottom_sheet/selected_part_list_item.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/searchable_dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/formatter/thousands_separator_input_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PartFormSection extends StatelessWidget {
  const PartFormSection({
    super.key,
    required this.isPartLoading,
    required this.partListNotifier,
    required this.selectedPart,
    required this.onPartSearchChanged,
    required this.onSelectPart,

    required this.partCostCenterListNotifier,
    required this.selectedPartCostCenter,
    required this.onSelectCostCenter,

    required this.partMarkListNotifier,
    required this.isPartMarkLoading,
    required this.selectedPartMark,
    required this.onSelectMark,

    required this.partPriceController,
    required this.partCountController,

    required this.isPriceLoading,

    required this.onAddPart,
    required this.selectedPartsNotifier,
    required this.onRemovePart,
  });

  // --- search part
  final ValueListenable<bool> isPartLoading;
  final ValueListenable<List<PartEntity>> partListNotifier;
  final ValueNotifier<PartEntity?> selectedPart;
  final ValueChanged<String> onPartSearchChanged;
  final ValueChanged<PartEntity> onSelectPart;

  // --- cost center
  final ValueListenable<List<AllowableCostCenterEntity>>
  partCostCenterListNotifier;
  final ValueNotifier<AllowableCostCenterEntity?> selectedPartCostCenter;
  final ValueChanged<AllowableCostCenterEntity> onSelectCostCenter;

  // --- mark
  final ValueListenable<List<PartMarkEntity>> partMarkListNotifier;
  final ValueListenable<bool> isPartMarkLoading;
  final ValueNotifier<PartMarkEntity?> selectedPartMark;
  final ValueChanged<PartMarkEntity> onSelectMark;

  // --- inputs
  final TextEditingController partPriceController;
  final TextEditingController partCountController;
  final ValueListenable<bool> isPriceLoading;

  // --- actions
  final VoidCallback onAddPart;
  final ValueListenable<List<EvaluationSelectedPartEntity>>
  selectedPartsNotifier;
  final ValueChanged<int> onRemovePart;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FormSectionContainer(
      hasBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title('قطعه'),
          const SizedBox(height: 12),

          _buildSearchPart(),
          const SizedBox(height: 12),

          _buildCostCenter(),
          const SizedBox(height: 12),

          _buildMark(),
          const SizedBox(height: 12),

          _buildPriceAndCount(),
          const SizedBox(height: 16),

          _addButton(context, colorScheme),

          ValueListenableBuilder(
            valueListenable: selectedPartsNotifier,
            builder: (context, List<EvaluationSelectedPartEntity> items, _) {
              if (items.isEmpty) return const SizedBox();

              return Column(
                children: [
                  const SizedBox(height: 16),
                  Divider(color: colorScheme.tertiary.withAlpha(100)),
                  const SizedBox(height: 8),
                  _selectedList(colorScheme, items),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _title(String t) => Text(
    t,
    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
  );

  Widget _buildSearchPart() {
    return ValueListenableBuilder(
      valueListenable: isPartLoading,
      builder: (context, loading, _) {
        return ValueListenableBuilder(
          valueListenable: partListNotifier,
          builder: (context, items, _) {
            return SearchableDropdownSelector<PartEntity>(
              label: 'نام قطعه',
              hintText: 'حداقل ۳ کاراکتر',
              controller: TextEditingController(),
              selectedNotifier: selectedPart,
              items: items,
              isLoading: loading,
              itemTitleBuilder: (e) => e.name ?? '',
              onSearchChanged: onPartSearchChanged,
              onSelect: onSelectPart,
            );
          },
        );
      },
    );
  }

  Widget _buildCostCenter() {
    return ValueListenableBuilder(
      valueListenable: partCostCenterListNotifier,
      builder: (context, items, _) {
        return DropdownSelector<AllowableCostCenterEntity>(
          label: 'مرکز هزینه',
          placeholder: 'انتخاب',
          selectedNotifier: selectedPartCostCenter,
          items: items,
          enabled: items.isNotEmpty,
          itemTitleBuilder: (e) => e.name ?? '',
          onSelect: onSelectCostCenter,
        );
      },
    );
  }

  Widget _buildMark() {
    return ValueListenableBuilder(
      valueListenable: isPartMarkLoading,
      builder: (context, loading, _) {
        return ValueListenableBuilder(
          valueListenable: partMarkListNotifier,
          builder: (context, items, _) {
            return DropdownSelector<PartMarkEntity>(
              label: 'مارک',
              placeholder: loading ? '...' : 'انتخاب مارک',
              selectedNotifier: selectedPartMark,
              items: items,
              isLoading: loading,
              enabled: items.isNotEmpty && !loading,
              itemTitleBuilder: (e) => e.mark ?? '',
              onSelect: onSelectMark,
            );
          },
        );
      },
    );
  }

  Widget _buildPriceAndCount() {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: isPriceLoading,
            builder: (context, loading, _) {
              return TextFormFieldWidget(
                controller: partPriceController,
                labelText: 'قیمت',
                textInputType: TextInputType.number,
                textInputFormatter: const [ThousandsSeparatorInputFormatter()],
                suffixIcon: loading
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormFieldWidget(
            controller: partCountController,
            labelText: 'تعداد',
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _addButton(BuildContext context, ColorScheme color) {
    return InkwellButtonWidget(
      title: 'افزودن قطعه',
      prefixIcon: Icon(Icons.add, color: color.primary),
      titleColor: color.primary,
      borderColor: color.primary,
      backgroundColor: Colors.transparent,
      onTap: onAddPart,
    );
  }

  Widget _selectedList(
    ColorScheme color,
    List<EvaluationSelectedPartEntity> items,
  ) {
    return Column(
      children: List.generate(items.length, (i) {
        final item = items[i];
        return Padding(
          padding: EdgeInsets.only(bottom: i == items.length - 1 ? 0 : 8),
          child: SelectedPartListItem(
            item: item,
            colorScheme: color,
            onDelete: () => onRemovePart(i),
          ),
        );
      }),
    );
  }
}
