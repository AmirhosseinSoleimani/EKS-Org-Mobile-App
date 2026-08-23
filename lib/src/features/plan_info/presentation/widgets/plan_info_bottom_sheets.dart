import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/cubit/plan_info_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanInfoBottomSheets {
  static void showFilterSheet({
    required BuildContext context,
    required PlanInfoCubit cubit,
  }) {
    showFilterBottomSheet<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const _PlanFilterSheet(),
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

    await DeleteConfirmSheet.show(
      context: context,
      title: 'لغو ماموریت',
      message: _buildCancelationMessage(cubit.state),
      confirmTitle: 'لغو ماموریت',
      icon: Icons.cancel_outlined,
      onConfirm: () async {
        await cubit.confirmCancelation(id);
      },
    );
  }

  static String _buildCancelationMessage(PlanInfoState state) {
    final requests = state.cancelation?.requests ?? const [];
    if (requests.isEmpty) {
      return 'درخواستی برای این برنامه یافت نشد. آیا از لغو ماموریت این برنامه‌ریزی مطمئن هستید؟';
    }

    final trackCodes = requests
        .map((item) => item.trackCode?.toString().trim())
        .whereType<String>()
        .where((item) => item.isNotEmpty)
        .join('، ');

    if (trackCodes.isEmpty) {
      return 'آیا از لغو ماموریت‌های این برنامه‌ریزی مطمئن هستید؟';
    }

    return 'آیا از لغو ماموریت‌های این برنامه‌ریزی مطمئن هستید؟\nکد پیگیری: $trackCodes';
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

    return BlocBuilder<PlanInfoCubit, PlanInfoState>(
      builder: (context, state) {
        return FilterBottomSheetScaffold(
          title: 'فیلترها',
          onApply: () {
            cubit
              ..setSeatTypeFilter(seatType)
              ..fetchPlans();
            Navigator.of(context).pop();
          },
          onClear: () {
            cubit.clearFilters();
            Navigator.of(context).pop();
          },
          child: Column(
            children: [
              _TextField(
                controller: cubit.titleController,
                label: 'عنوان',
                maxLength: 20,
                bottomSpacing: FilterBottomSheetScaffold.fieldSpacing,
              ),
              _TextField(
                controller: cubit.emdadUnitController,
                label: 'واحد امدادی',
                bottomSpacing: FilterBottomSheetScaffold.fieldSpacing,
              ),
              _TextField(
                controller: cubit.shiftController,
                label: 'شیفت',
                bottomSpacing: FilterBottomSheetScaffold.fieldSpacing,
              ),
              _TextField(
                controller: cubit.specialPlanController,
                label: 'طرح',
                bottomSpacing: FilterBottomSheetScaffold.fieldSpacing,
              ),
              _LookupField(
                label: 'نوع مقر',
                value: seatType,
                items: state.seatTypes,
                includeEmpty: true,
                onChanged: (value) => setState(() => seatType = value),
                bottomSpacing: FilterBottomSheetScaffold.fieldSpacing,
              ),
              _TextField(
                controller: cubit.locationController,
                label: 'محل استقرار',
                bottomSpacing: FilterBottomSheetScaffold.fieldSpacing,
              ),
              _TextField(
                controller: cubit.fromDateController,
                label: 'تاریخ شروع',
                bottomSpacing: FilterBottomSheetScaffold.fieldSpacing,
              ),
              _TextField(
                controller: cubit.toDateController,
                label: 'تاریخ پایان',
                bottomSpacing: AppSize.s0,
              ),
            ],
          ),
        );
      },
    );
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
                    onTap: () async {
                      if (state.isSubmitting) return;
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

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int? maxLength;
  final int maxLines;
  final double bottomSpacing;

  const _TextField({
    required this.controller,
    required this.label,
    this.maxLength,
    this.maxLines = 1,
    this.bottomSpacing = AppPadding.p12,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
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
  final double bottomSpacing;

  const _LookupField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.includeEmpty = false,
    this.bottomSpacing = AppPadding.p12,
  });

  @override
  Widget build(BuildContext context) {
    final validItems = items.where((item) => item.resolvedId != null).toList();
    final titles = <String>[
      if (includeEmpty) 'همه',
      ...validItems.map((item) => item.displayTitle),
    ];

    if (titles.isEmpty) return const SizedBox.shrink();

    var selectedTitle = includeEmpty ? 'همه' : titles.first;
    for (final item in validItems) {
      if (item.resolvedId == value) {
        selectedTitle = item.displayTitle;
        break;
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: EkDropDown(
        titles,
        key: ValueKey('$label-${titles.join('|')}'),
        label: label,
        selectedItem: selectedTitle,
        onItemValue: (selected) {
          if (selected == 'همه') {
            onChanged(null);
            return;
          }
          for (final item in validItems) {
            if (item.displayTitle == selected) {
              onChanged(item.resolvedId);
              return;
            }
          }
          onChanged(null);
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

