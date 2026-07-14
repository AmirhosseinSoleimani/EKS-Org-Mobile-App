import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/drop_down_map_items_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanInfoBottomSheets {
  static void showFilterSheet({
    required BuildContext context,
    required PlanInfoCubit cubit,
  }) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const _PlanFilterSheet(),
      ),
    );
  }

  static Future<void> showPlanForm({
    required BuildContext context,
    required PlanInfoCubit cubit,
    PlanInfoEntity? plan,
    bool isCopy = false,
  }) async {
    final initialPlan = plan?.resolvedId == null ? plan : await cubit.getPlanById(plan!.resolvedId!);
    if (plan != null && initialPlan == null) return;

    if (!context.mounted) return;

    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: _PlanFormSheet(plan: initialPlan, isCopy: isCopy),
      ),
    );
  }

  static Future<void> showStatusSheet({
    required BuildContext context,
    required PlanInfoCubit cubit,
    required PlanInfoEntity plan,
  }) async {
    await cubit.loadStatusReasons();
    if (!context.mounted) return;

    BottomSheetMessage.showCustom(
        backgroundColor: Colors.white,
        context: context, content: BlocProvider.value(
      value: cubit,
      child: _PlanStatusSheet(plan: plan),
    ),
        actionWidget: SizedBox.shrink());
    /*  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) =>,
    );*/
  }

  static Future<void> showCancelationSheet({
    required BuildContext context,
    required PlanInfoCubit cubit,
    required PlanInfoEntity plan,
  }) async {
    final id = plan.resolvedId;
    if (id == null) return;

    await cubit.previewCancelation(id);
    if (!context.mounted) return;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: _PlanCancelationSheet(plan: plan),
      ),
    );
  }

  static void showLocationInfo({
    required BuildContext context,
    required PlanInfoEntity plan,
  }) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('محل استقرار', style: Theme.of(context).textTheme.titleMedium),
                Space.h16,
                _ReadOnlyRow(label: 'عنوان', value: plan.locationTitle),
                _ReadOnlyRow(label: 'آدرس', value: plan.address),
                _ReadOnlyRow(label: 'عرض جغرافیایی', value: plan.latitude?.toString()),
                _ReadOnlyRow(label: 'طول جغرافیایی', value: plan.longitude?.toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PlanFilterSheet extends StatefulWidget {
  const _PlanFilterSheet();

  @override
  State<_PlanFilterSheet> createState() => _PlanFilterSheetState();
}

class _PlanFilterSheetState extends State<_PlanFilterSheet> {

  int? seatType;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<PlanInfoCubit>();

    seatType = cubit.seatTypeFilter;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlanInfoCubit>();
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p16,
          AppPadding.p16,
          bottomInset + AppPadding.p16,
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<PlanInfoCubit, PlanInfoState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space.h8,
                  Text('جستجو و فیلتر', style: Theme.of(context).textTheme.titleMedium),
                  Space.h24,
                  _TextField(controller: cubit.titleController, label: 'عنوان', maxLength: 20),
                  _TextField(controller: cubit.emdadUnitController, label: 'واحد امدادی'),
                  _TextField(controller: cubit.shiftController, label: 'شیفت'),
                  _TextField(controller: cubit.specialPlanController, label: 'طرح'),
                  Space.h8,
                  _LookupField(
                    label: 'نوع مقر',
                    value: seatType,
                    items: state.seatTypes,
                    includeEmpty: true,
                    onChanged: (value) => setState(() => seatType = value),
                  ),
                  _TextField(controller: cubit.locationController, label: 'محل استقرار'),
                  _TextField(controller: cubit.fromDateController, label: 'تاریخ شروع'),
                  _TextField(controller: cubit.toDateController, label: 'تاریخ پایان'),
                  Space.h16,
                  Row(
                    children: [
                      Expanded(
                        child: InkwellButtonWidget(
                          title: 'اعمال فیلتر',
                          onTap: () {
                            cubit
                              ..setSeatTypeFilter(seatType)
                              ..fetchPlans();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Space.w12,
                      Expanded(
                        child: InkwellButtonWidget(
                          backgroundColor: Colors.transparent,
                          title: 'پاک کردن فیلتر',
                          titleColor: colorScheme.onTertiaryFixed,
                          onTap: () {
                            cubit.clearFilters();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),

                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PlanFormSheet extends StatefulWidget {
  final PlanInfoEntity? plan;
  final bool isCopy;

  const _PlanFormSheet({
    this.plan,
    required this.isCopy,
  });

  @override
  State<_PlanFormSheet> createState() => _PlanFormSheetState();
}

class _PlanFormSheetState extends State<_PlanFormSheet> {
  int? emdadUnitId;
  int? shiftId;
  int? specialPlanId;
  int? seatType;
  int? locationId;
  bool hasSpecialPlan = false;
  late final TextEditingController fromDateController;
  late final TextEditingController toDateController;

  @override
  void initState() {
    super.initState();
    final plan = widget.plan;
    emdadUnitId = plan?.emdadUnitId;
    shiftId = plan?.shiftId;
    specialPlanId = plan?.specialPlanId;
    seatType = plan?.seatType;
    locationId = plan?.locationId;
    hasSpecialPlan = plan?.specialPlanId != null;
    fromDateController = TextEditingController(
      text: plan?.fromDateJalali ?? plan?.fromDate ?? '',
    );
    toDateController = TextEditingController(
      text: plan?.toDateJalali ?? plan?.toDate ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlanInfoCubit>();
    final plan = widget.plan;
    final isEdit = plan != null && !widget.isCopy;
    final title = widget.isCopy
        ? 'کپی از برنامه‌ریزی ${plan?.title ?? ''}'
        : isEdit
            ? 'ویرایش برنامه‌ریزی'
            : 'ثبت برنامه‌ریزی جدید';
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p16,
          AppPadding.p16,
          bottomInset + AppPadding.p16,
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<PlanInfoCubit, PlanInfoState>(
            builder: (context, state) {
              final selectedLocation = _findLookup(state.locations, locationId);

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
                  Space.h16,
                  _LookupField(
                    label: 'واحد امدادی',
                    value: emdadUnitId,
                    items: state.emdadUnits,
                    onChanged: (value) => setState(() => emdadUnitId = value),
                  ),
                  _LookupField(
                    label: 'شیفت‌ها',
                    value: shiftId,
                    items: state.shifts,
                    onChanged: (value) => setState(() => shiftId = value),
                  ),
                  _TextField(controller: fromDateController, label: 'تاریخ شروع'),
                  _TextField(controller: toDateController, label: 'تاریخ پایان'),
                  SwitchListTile(
                    value: hasSpecialPlan,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('دارای طرح'),
                    onChanged: (value) => setState(() => hasSpecialPlan = value),
                  ),
                  if (hasSpecialPlan)
                    _LookupField(
                      label: 'طرح‌ها',
                      value: specialPlanId,
                      items: state.specialPlans,
                      onChanged: (value) => setState(() => specialPlanId = value),
                    ),
                  _LookupField(
                    label: 'نوع مقر',
                    value: seatType,
                    items: state.seatTypes,
                    onChanged: (value) => setState(() => seatType = value),
                  ),
                  _LookupField(
                    label: 'محل استقرار',
                    value: locationId,
                    items: state.locations,
                    onChanged: (value) => setState(() => locationId = value),
                  ),
                  if (selectedLocation != null) ...[
                    Space.h8,
                    _ReadOnlyRow(label: 'آدرس محل استقرار', value: selectedLocation.address),
                    _ReadOnlyRow(label: 'عرض جغرافیایی', value: selectedLocation.latitude?.toString()),
                    _ReadOnlyRow(label: 'طول جغرافیایی', value: selectedLocation.longitude?.toString()),
                  ],
                  Space.h16,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('انصراف'),
                        ),
                      ),
                      Space.w12,
                      Expanded(
                        child: FilledButton(
                          onPressed: state.isSubmitting
                              ? null
                              : () async {
                                  final saved = await cubit.savePlan(
                                    id: plan?.resolvedId,
                                    isEdit: isEdit,
                                    isCopy: widget.isCopy,
                                    emdadUnitId: emdadUnitId,
                                    shiftId: shiftId,
                                    fromDate: fromDateController.text,
                                    toDate: toDateController.text,
                                    hasSpecialPlan: hasSpecialPlan,
                                    specialPlanId: specialPlanId,
                                    seatType: seatType,
                                    locationId: locationId,
                                  );
                                  if (saved && context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                          child: Text(isEdit ? 'ویرایش' : 'ثبت'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }
}

class _PlanStatusSheet extends StatefulWidget {
  final PlanInfoEntity plan;

  const _PlanStatusSheet({
    required this.plan,
  });

  @override
  State<_PlanStatusSheet> createState() => _PlanStatusSheetState();
}

class _PlanStatusSheetState extends State<_PlanStatusSheet> {
  int? reasonId;
  int? statusId;

  final descriptionController = TextEditingController();

  final List<PlanLookupEntity> statusItems = const [
    PlanLookupEntity(
      id: 1,
      value: 1,
      title: 'فعال',
    ),
    PlanLookupEntity(
      id: 0,
      value: 2,
      title: 'غیرفعال',
    ),
  ];

  @override
  void initState() {
    super.initState();

    reasonId = widget.plan.reasonId;
    statusId = widget.plan.isActive ? 1 : 0;
    descriptionController.text = widget.plan.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlanInfoCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<PlanInfoCubit, PlanInfoState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleLargeText(
              text: 'تغییر وضعیت',
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
            Space.h24,
            _LookupField(
              label: 'وضعیت',
              value: statusId,
              items: statusItems,
              onChanged: (value) {
                setState(() {
                  statusId = value;
                });
              },
            ),
            _LookupField(
              label: 'دلیل',
              value: reasonId,
              items: state.statusReasons,
              onChanged: (value) {
                setState(() {
                  reasonId = value;
                });
              },
            ),
            TextFormFieldWidget(
              labelText: 'توضیحات',
              hintText: 'توضیحات تکمیلی خود را بنویسید...',
              controller: descriptionController,
              autofocus: false,
              textInputType: TextInputType.text,
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.done,
              maxLines: 3,
              maxLength: 350,
              mandatory: true,
            ),

            Space.h64,

            Row(
              children: [
                Expanded(
                  child: InkwellButtonWidget(
                    title: 'ثبت تغییرات',
                    onTap: state.isSubmitting
                        ? null
                        : () async {
                      final planId = widget.plan.resolvedId;

                      if (planId == null) {
                        return;
                      }

                      final saved = await cubit.changeStatus(
                        planId: planId,
                        isActive: statusId == 1,
                        reasonId: reasonId,
                        description: descriptionController.text,
                      );

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),

                Space.w12,

                Expanded(
                  child: InkwellButtonWidget(
                    title: 'انصراف',
                    titleColor: colorScheme.onPrimaryFixed,
                    borderColor: colorScheme.onPrimaryFixed,
                    backgroundColor: Colors.transparent,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}

class _PlanCancelationSheet extends StatelessWidget {
  final PlanInfoEntity plan;

  const _PlanCancelationSheet({required this.plan});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlanInfoCubit>();
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p16,
          AppPadding.p16,
          bottomInset + AppPadding.p16,
        ),
        child: BlocBuilder<PlanInfoCubit, PlanInfoState>(
          builder: (context, state) {
            final requests = state.cancelation?.requests ?? const [];

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'لغو ماموریت ${plan.title ?? ''}',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Space.h16,
                  if (requests.isEmpty)
                    const Center(child: Text('درخواستی برای این برنامه یافت نشد.'))
                  else ...[
                    const Text('آیا از لغو ماموریت‌های زیر اطمینان دارید؟'),
                    Space.h12,
                    Wrap(
                      spacing: AppSize.s8,
                      runSpacing: AppSize.s8,
                      children: requests
                          .map(
                            (item) => Chip(
                              avatar: const Icon(Icons.confirmation_number_outlined),
                              label: Text(item.trackCode?.toString() ?? '---'),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  Space.h16,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('انصراف'),
                        ),
                      ),
                      Space.w12,
                      Expanded(
                        child: FilledButton(
                          onPressed: state.isSubmitting
                              ? null
                              : () async {
                                  final id = plan.resolvedId;
                                  if (id == null) return;
                                  final saved = await cubit.confirmCancelation(id);
                                  if (saved && context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                          child: const Text('ثبت'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int? maxLength;
  final int maxLines;

  const _TextField({
    required this.controller,
    required this.label,
    this.maxLength,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p12),
      child: TextFormFieldWidget(
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
        labelText: label,
      ),
    );
  }
}

class _LookupField extends StatelessWidget {
  final String label;
  final int? value;
  final List<PlanLookupEntity> items;
  final bool includeEmpty;
  final ValueChanged<int?> onChanged;

  const _LookupField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.includeEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    final validItems = items
        .where((item) => item.resolvedId != null)
        .toList();

    final dropdownItems = <String, int>{
      if (includeEmpty) 'همه': -1,
      for (final item in validItems)
        item.displayTitle: item.resolvedId!,
    };

    String? selectedTitle;

    if (value == null && includeEmpty) {
      selectedTitle = 'همه';
    } else {
      for (final item in validItems) {
        if (item.resolvedId == value) {
          selectedTitle = item.displayTitle;
          break;
        }
      }
    }

    if (dropdownItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppPadding.p12,
      ),
      child: DropDownMapItemsWidget(
        labelText: label,
        items: dropdownItems,
        initialValue: selectedTitle,
        onChange: (selectedTitle) {
          final selectedId = dropdownItems[selectedTitle];

          if (selectedId == null || selectedId == -1) {
            onChanged(null);
            return;
          }

          onChanged(selectedId);
        },
      ),
    );
  }
}

class _ReadOnlyRow extends StatelessWidget {
  final String label;
  final String? value;

  const _ReadOnlyRow({
    required this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = value?.trim().isNotEmpty == true ? value! : '---';

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: Theme.of(context).textTheme.labelLarge),
          Expanded(child: Text(displayValue)),
        ],
      ),
    );
  }
}

PlanLookupEntity? _findLookup(List<PlanLookupEntity> items, int? id) {
  if (id == null) return null;
  for (final item in items) {
    if (item.resolvedId == id) return item;
  }
  return null;
}
