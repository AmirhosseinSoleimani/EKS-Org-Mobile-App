import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_aid_service_request_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/bottom_sheet/service_action_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/searchable_dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/formatter/thousands_separator_input_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'selected_part_list_item.dart';
Future<void> showAddPartAndLaborBottomSheet(BuildContext context) async {
  final cubit = context.read<EvaluationAidServiceRequestCubit>();

  await showServiceActionBottomSheet(
    context: context,
    cubit: cubit,
    title: 'ثبت اجرت/قطعه',
    contentBuilder: (context) {
      return AddPartAndLaborForm(
        requestEntity: cubit.selectedRequest,
        descriptionController: cubit.mainForm.descriptionController,
      );
    },
    actionsBuilder: (context) {
      return BlocBuilder<
          EvaluationAidServiceRequestCubit,
          EvaluationAidServiceRequestState
      >(
        builder: (context, state) {
          final isLoading =
              state.whenOrNull(submitLoading: () => true) ?? false;

          return SubmitCancelButtons(
            submitTitle: 'افزودن اجرت/قطعه',
            isLoading: isLoading,
            submitButtonColor:
            cubit.selectedRequest?.serviceType?.serviceColor ??
                ServiceType.reliefService.serviceColor,
            onCancel: () => Navigator.pop(context),
            onSubmit: () {
              final added = cubit.saveLaborAndPartsFromSheet();
              if (added) {
                Navigator.pop(context);
              }
            },
          );
        },
      );
    },
  );
}


class AddPartAndLaborForm extends StatelessWidget {
  final BaseRequestEntity? requestEntity;
  final TextEditingController descriptionController;

  const AddPartAndLaborForm({
    super.key,
    required this.requestEntity,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EvaluationAidServiceRequestCubit>();

    return BlocBuilder<EvaluationAidServiceRequestCubit,
        EvaluationAidServiceRequestState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLaborDetailsSection(
              context: context,
              cubit: cubit,
              state: state,
            ),
            const SizedBox(height: 16),
            _buildPartSection(
              context: context,
              cubit: cubit,
              state: state,
            ),
          ],
        );
      },
    );
  }

  Widget _buildLaborDetailsSection({
    required BuildContext context,
    required EvaluationAidServiceRequestCubit cubit,
    required EvaluationAidServiceRequestState state,
  }) {
    return FormSectionContainer(
      hasBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('جزئیات اجرت'),
          const SizedBox(height: 12),
          _buildLaborSearchDropdown(cubit),
          const SizedBox(height: 12),
          _buildLaborCostCenterDropdown(cubit),
          const SizedBox(height: 12),
          _buildLaborPriceInput(cubit),
        ],
      ),
    );
  }

  Widget _buildPartSection({
    required BuildContext context,
    required EvaluationAidServiceRequestCubit cubit,
    required EvaluationAidServiceRequestState state,
  }) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    return FormSectionContainer(
      hasBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('قطعه'),
          const SizedBox(height: 12),
          _buildPartSearchDropdown(cubit),
          const SizedBox(height: 12),
          _buildPartCostCenterDropdown(cubit),
          const SizedBox(height: 12),
          _buildPartMarkDropdown(cubit),
          const SizedBox(height: 12),
          _buildPartPriceAndCountRow(cubit, state),
          const SizedBox(height: 16),
          _buildAddAnotherPartButton(context, cubit, colorScheme),
          ValueListenableBuilder<List<EvaluationSelectedPartEntity>>(
            valueListenable: cubit.selectedPartsNotifier,
            builder: (context, selectedParts, _) {
              if (selectedParts.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Divider(thickness: AppSize.s1,
                    color: colorScheme.tertiary.withAlpha(100),),
                  const SizedBox(height: 8),
                  _buildSelectedPartsPlaceholder(context, cubit,),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildLaborSearchDropdown(EvaluationAidServiceRequestCubit cubit) {
    return ValueListenableBuilder<bool>(
      valueListenable: cubit.isLaborLoading,
      builder: (context, isLoading, _) {
        return ValueListenableBuilder<List<LaborEntity>>(
          valueListenable: cubit.laborListNotifier,
          builder: (context, items, _) {
            return SearchableDropdownSelector<LaborEntity>(
              label: 'نام اجرت',
              hintText: 'حداقل ۳ کاراکتر وارد کنید',
              controller: cubit.laborSearchController,
              selectedNotifier: cubit.selectedLabor,
              items: items,
              isLoading: isLoading,
              itemTitleBuilder: (item) => item.name ?? '',
              onSearchChanged: cubit.onLaborSearchChanged,
              onSelect: cubit.selectLabor,
            );
          },
        );
      },
    );
  }

  Widget _buildLaborCostCenterDropdown(EvaluationAidServiceRequestCubit cubit) {
    return ValueListenableBuilder<List<AllowableCostCenterEntity>>(
      valueListenable: cubit.laborCostCenterListNotifier,
      builder: (context, items, _) {
        return DropdownSelector<AllowableCostCenterEntity>(
          label: 'مرکز هزینه',
          placeholder: 'انتخاب مرکز هزینه',
          selectedNotifier: cubit.selectedLaborCostCenter,
          items: items,
          enabled: items.isNotEmpty,
          itemTitleBuilder: (item) => item.name ?? '',
          onSelect: cubit.selectLaborCostCenter,
        );
      },
    );
  }

  Widget _buildLaborPriceInput(EvaluationAidServiceRequestCubit cubit) {
    return TextFormFieldWidget(
      controller: cubit.laborPriceController,
      labelText: 'قیمت (ریال)',
      hintText: 'قیمت',
      readOnly: true,
      textInputFormatter: const [
        ThousandsSeparatorInputFormatter(),
      ],
    );
  }

  Widget _buildPartSearchDropdown(EvaluationAidServiceRequestCubit cubit) {
    return ValueListenableBuilder<bool>(
      valueListenable: cubit.isPartLoading,
      builder: (context, isLoading, _) {
        return ValueListenableBuilder<List<PartEntity>>(
          valueListenable: cubit.partListNotifier,
          builder: (context, items, _) {
            return SearchableDropdownSelector<PartEntity>(
              label: 'نام قطعه',
              hintText: 'حداقل ۳ کاراکتر وارد کنید',
              controller: cubit.partSearchController,
              selectedNotifier: cubit.selectedPart,
              items: items,
              isLoading: isLoading,
              itemTitleBuilder: (item) => item.name ?? '',
              onSearchChanged: cubit.onPartSearchChanged,
              onSelect: cubit.selectPart,
            );
          },
        );
      },
    );
  }

  Widget _buildPartCostCenterDropdown(EvaluationAidServiceRequestCubit cubit) {
    return ValueListenableBuilder<List<AllowableCostCenterEntity>>(
      valueListenable: cubit.partCostCenterListNotifier,
      builder: (context, items, _) {
        return DropdownSelector<AllowableCostCenterEntity>(
          label: 'مرکز هزینه',
          placeholder: 'انتخاب مرکز هزینه',
          selectedNotifier: cubit.selectedPartCostCenter,
          items: items,
          enabled: items.isNotEmpty,
          itemTitleBuilder: (item) => item.name ?? '',
          onSelect: cubit.selectPartCostCenter,
        );
      },
    );
  }

  Widget _buildPartMarkDropdown(EvaluationAidServiceRequestCubit cubit) {
    return ValueListenableBuilder<bool>(
      valueListenable: cubit.isPartMarkLoading,
      builder: (context, isLoading, _) {
        return ValueListenableBuilder<List<PartMarkEntity>>(
          valueListenable: cubit.partMarkListNotifier,
          builder: (context, items, _) {
            return DropdownSelector<PartMarkEntity>(
              label: 'مارک ها',
              placeholder: isLoading ? 'در حال بارگذاری...' : 'انتخاب مارک',
              selectedNotifier: cubit.selectedPartMark,
              items: items,
              isLoading: isLoading,
              enabled: items.isNotEmpty && !isLoading,
              itemTitleBuilder: (item) => item.mark ?? '',
              onSelect: cubit.selectPartMark,
            );
          },
        );
      },
    );
  }

  Widget _buildPartPriceAndCountRow(
      EvaluationAidServiceRequestCubit cubit,
      EvaluationAidServiceRequestState state,
      ) {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: cubit.isPartPriceLoading,
            builder: (context, isLoading, _) {
              return TextFormFieldWidget(
                controller: cubit.partPriceController,
                labelText: 'قیمت',
                hintText: 'قیمت',
                textInputType: TextInputType.number,
                textInputFormatter: const [
                  ThousandsSeparatorInputFormatter(),
                ],
                suffixIcon: isLoading
                    ? const Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                    : null,
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormFieldWidget(
            controller: cubit.partCountController,
            labelText: 'تعداد',
            hintText: 'تعداد',
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildAddAnotherPartButton(BuildContext context,
      EvaluationAidServiceRequestCubit cubit, ColorScheme colorScheme) {


    return InkwellButtonWidget(
      title: 'افزودن قطعه دیگر',
      prefixIcon: Icon(Icons.add, color: colorScheme.primary),
      titleColor: colorScheme.primary,
      borderColor: colorScheme.primary,
      backgroundColor: Colors.transparent,
      onTap: cubit.addAnotherPart,
    );
  }

  Widget _buildSelectedPartsPlaceholder(BuildContext context,
      EvaluationAidServiceRequestCubit cubit,) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return ValueListenableBuilder<List<EvaluationSelectedPartEntity>>(
      valueListenable: cubit.selectedPartsNotifier,
      builder: (context, items, _) {
        if (items.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          children: List.generate(items.length, (index) {
            final item = items[index];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == items.length - 1 ? 0 : 8,
              ),
              child: SelectedPartListItem(
                item: item,
                colorScheme: colorScheme,
                onDelete: () => cubit.removeSelectedPartAt(index),
              ),
            );
          }),
        );
      },
    );
  }
}

