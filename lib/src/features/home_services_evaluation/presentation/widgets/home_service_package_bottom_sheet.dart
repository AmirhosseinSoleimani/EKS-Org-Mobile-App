import 'dart:async';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_package_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_part_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_category_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_state.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/searchable_dropdown_selector.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeServicePackageBottomSheet extends StatefulWidget {
  const HomeServicePackageBottomSheet({super.key});

  @override
  State<HomeServicePackageBottomSheet> createState() =>
      _HomeServicePackageBottomSheetState();
}

class _HomeServicePackageBottomSheetState
    extends State<HomeServicePackageBottomSheet> {
  final ValueNotifier<ServiceCategoryResponseEntity?> _categoryNotifier =
      ValueNotifier<ServiceCategoryResponseEntity?>(null);

  final ValueNotifier<EmdadServiceResultEntity?> _serviceNotifier =
      ValueNotifier<EmdadServiceResultEntity?>(null);

  final TextEditingController _serviceController = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _categoryNotifier.dispose();
    _serviceNotifier.dispose();
    _serviceController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      context.read<HomeServiceEvaluationCubit>().searchServices(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeServiceEvaluationCubit, HomeServiceEvaluationState>(
      builder: (context, state) {
        final cubit = context.read<HomeServiceEvaluationCubit>();
        final data = state.data;

        final isLoading = state.maybeWhen(
          sheetLoading: (_, sheetType) => true,
          orElse: () => false,
        );

        if (_categoryNotifier.value?.id != data.selectedServiceCategory?.id) {
          _categoryNotifier.value = data.selectedServiceCategory;
        }

        if (_serviceNotifier.value?.serviceId !=
            data.selectedService?.serviceId) {
          _serviceNotifier.value = data.selectedService;
        }

        return Padding(
          padding: EdgeInsets.only(
            left: AppSize.s16,
            right: AppSize.s16,
            top: AppSize.s16,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSize.s16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TitleMediumText(text: 'افزودن سرویس'),
                const SizedBox(height: AppSize.s16),

                FormSectionContainer(
                  hasBorder: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const BodyMediumText(text: 'جزئیات سرویس'),
                      const SizedBox(height: AppSize.s12),

                      DropdownSelector<ServiceCategoryResponseEntity>(
                        label: 'دسته‌بندی سرویس',
                        placeholder: 'اجرت را انتخاب کنید',
                        selectedNotifier: _categoryNotifier,
                        items: data.serviceCategories,
                        itemTitleBuilder: (item) => item.title ?? '',
                        onSelect: (item) {
                          _serviceController.clear();
                          _serviceNotifier.value = null;
                          cubit.selectServiceCategory(item);
                        },
                      ),

                      const SizedBox(height: AppSize.s12),

                      SearchableDropdownSelector<EmdadServiceResultEntity>(
                        label: 'سرویس',
                        hintText: data.selectedServiceCategory == null
                            ? 'ابتدا دسته‌بندی سرویس را انتخاب کنید'
                            : 'حداقل ۳ کاراکتر تایپ کنید',
                        enabled: data.selectedServiceCategory != null,
                        controller: _serviceController,
                        selectedNotifier: _serviceNotifier,
                        items: data.serviceList,
                        isLoading: isLoading,
                        itemTitleBuilder: (item) => item.serviceTitle ?? '',
                        onSearchChanged: _onSearchChanged,
                        onSelect: (item) {
                          _serviceController.text = item.serviceTitle ?? '';
                          _serviceNotifier.value = item;
                          cubit.selectService(item);
                        },
                      ),
                    ],
                  ),
                ),

                FormSectionContainer(
                  hasBorder: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const BodyMediumText(text: 'لیست اجرت و قطعه'),
                      const SizedBox(height: AppSize.s12),

                      if (isLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSize.s24),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (data.packageItems.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSize.s16),
                          child: EmptyListWidget(),
                        )
                      else
                        ...data.packageItems.map(
                          (item) => _PackageLaborItem(entity: item),
                        ),
                    ],
                  ),
                ),

                SubmitCancelButtons(
                  submitTitle: 'افزودن سرویس',
                  submitButtonColor: ServiceType.homeService.serviceColor,
                  cancelTitle: 'بستن',
                  isLoading: isLoading,
                  onSubmit: cubit.canConfirmPackageSelection
                      ? () {
                          cubit.confirmPackageSelection();
                          Navigator.of(context).pop();
                        }
                      : null,
                  onCancel: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PackageLaborItem extends StatelessWidget {
  const _PackageLaborItem({required this.entity});

  final HomeServicePackageResponseEntity entity;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServiceEvaluationCubit>();
    final hasParts = entity.partGroups?.isNotEmpty == true;
    final color = ServiceType.homeService.serviceColor;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.s12),
      padding: const EdgeInsets.all(AppSize.s12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!hasParts)
                Checkbox(
                  value: entity.isMandatory == true || entity.isSelected,
                  activeColor: color,
                  onChanged: entity.isMandatory == true
                      ? null
                      : (value) {
                          cubit.togglePackageLabor(
                            laborId: entity.laborId ?? 0,
                            selected: value ?? false,
                          );
                        },
                ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyMediumText(
                      text:
                          entity.laborTitle ??
                          entity.laborDesc ??
                          entity.serviceTitle ??
                          '-',
                      maxLines: 2,
                    ),
                    const SizedBox(height: AppSize.s6),
                    BodySmallText(text: _formatPrice(entity.laborPrice)),
                  ],
                ),
              ),

              const SizedBox(width: AppSize.s8),

              StatusLabel(
                text:
                    entity.laborCostCenter?.name ??
                    entity.laborCostCenterTitle ??
                    '-',
                color: color,
                variant: StatusLabelVariant.filled,
                fontSize: 11,
              ),
            ],
          ),

          if (hasParts) ...[
            const SizedBox(height: AppSize.s12),
            ...entity.partGroups!.map(
              (group) => _PartGroup(laborId: entity.laborId ?? 0, group: group),
            ),
          ],
        ],
      ),
    );
  }

  static String _formatPrice(int? price) {
    return '${(price ?? 0).toString().splitPriceByComma().convertNumberWithLanguage()} ریال';
  }
}

class _PartGroup extends StatelessWidget {
  const _PartGroup({required this.laborId, required this.group});

  final int laborId;
  final HomeServicePartGroupEntity group;

  @override
  Widget build(BuildContext context) {
    final parts = group.parts ?? const <HomeServicePartEntity>[];
    final selectedPart = parts.firstWhere(
      (part) => part.isSelected == true || part.isMandatory == true,
      orElse: () => const HomeServicePartEntity(),
    );
    final mandatoryLocked = parts.any((part) => part.isMandatory == true);

    return Padding(
      padding: const EdgeInsets.only(top: AppSize.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BodySmallText(
            text: group.partGroupTitle ?? group.partGroupId?.toString() ?? '-',
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: AppSize.s4),

          ...parts.map((part) {
            return _PartRadioTile(
              laborId: laborId,
              group: group,
              part: part,
              groupValue: selectedPart.serial,
              locked: mandatoryLocked,
            );
          }),
        ],
      ),
    );
  }
}

class _PartRadioTile extends StatelessWidget {
  const _PartRadioTile({
    required this.laborId,
    required this.group,
    required this.part,
    required this.groupValue,
    required this.locked,
  });

  final int laborId;
  final HomeServicePartGroupEntity group;
  final HomeServicePartEntity part;
  final int? groupValue;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final color = ServiceType.homeService.serviceColor;

    return RadioListTile<int?>(
      value: part.serial,
      groupValue: groupValue,
      activeColor: color,
      dense: true,
      contentPadding: EdgeInsets.zero,
      onChanged: locked
          ? null
          : (_) {
              final serial = part.serial;
              final partGroupId = group.partGroupId;

              if (serial == null || partGroupId == null) return;

              context.read<HomeServiceEvaluationCubit>().selectPackagePart(
                laborId: laborId,
                partGroupId: partGroupId,
                serial: serial,
              );
            },
      title: Row(
        children: [
          Expanded(
            child: BodySmallText(text: part.partTitle ?? '-', maxLines: 2),
          ),
          const SizedBox(width: AppSize.s8),
          StatusLabel(
            text: part.partCostCenter?.name ?? part.partCostCenterTitle ?? '-',
            color: color,
            variant: StatusLabelVariant.filled,
            fontSize: 10,
          ),
        ],
      ),
      subtitle: BodySmallText(text: _formatPrice(part.partPrice)),
    );
  }

  static String _formatPrice(int? price) {
    return '${(price ?? 0).toString().splitPriceByComma().convertNumberWithLanguage()} ریال';
  }
}
