import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_person_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/cubit/emdad_unit_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/drop_down_map_items_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmdadUnitPersonsPage extends StatelessWidget {
  static const path = '/emdad-unit-persons-page';
  static const name = 'emdad-unit-persons-page';

  const EmdadUnitPersonsPage({super.key, required this.item});

  final EmdadUnitEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EmdadUnitCubit>()..loadPersons(item),
      child: _EmdadUnitPersonsView(item: item),
    );
  }
}

class _EmdadUnitPersonsView extends StatefulWidget {
  const _EmdadUnitPersonsView({required this.item});

  final EmdadUnitEntity item;

  @override
  State<_EmdadUnitPersonsView> createState() => _EmdadUnitPersonsViewState();
}

class _EmdadUnitPersonsViewState extends State<_EmdadUnitPersonsView> {
  int? _selectedPersonId;
  bool _changed = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmdadUnitCubit>();
    final theme = Theme.of(context);

    return BlocListener<EmdadUnitCubit, EmdadUnitState>(
      listener: (context, state) {
        if (state.status == EmdadUnitViewStatus.failure && state.message != null) {
          SnakeBarWidget.showError(context: context, message: state.message!);
        }
        if (state.status == EmdadUnitViewStatus.success && state.message != null) {
          _changed = true;
          setState(() => _selectedPersonId = null);
          SnakeBarWidget.showSuccess(context: context, message: state.message!);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          context.pop(_changed);
          return false;
        },
        child: Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: const SimpleAppBar(title: 'مدیریت امدادرسان‌ها'),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s4),
              bottomLeft: Radius.circular(AppSize.s4),
            ),),
            child: SafeArea(
              minimum: const EdgeInsets.all(AppPadding.p16),
              child: InkwellButtonWidget(
                title: 'بستن',
                backgroundColor: theme.colorScheme.onPrimary,
                borderColor: theme.colorScheme.outline.withOpacity(0.65),
                titleColor: theme.colorScheme.onSurface,
                borderWidth: 2,
                onTap: () => context.pop(_changed),
              ),
            ),
          ),
          body: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
            builder: (context, state) {
              if (state.status == EmdadUnitViewStatus.loading && state.persons.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              final eligiblePersons = _eligiblePersons(state);
              return ListView(
                padding: const EdgeInsets.all(AppPadding.p16),
                children: [
                  EmdadUnitSummaryCard(item: widget.item),
                  Space.h16,
                  _AddPersonCard(
                    selectedPersonId: _selectedPersonId,
                    persons: eligiblePersons,
                    isSubmitting: state.status == EmdadUnitViewStatus.submitting,
                    onChanged: (value) => setState(() => _selectedPersonId = value),
                    onSubmit: () => _assignPerson(context, cubit),
                  ),
                  Space.h24,
                  Row(
                    children: [
                      Text(
                        'امدادرسان‌های ثبت‌شده',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      _CountBadge(count: state.persons.length),
                    ],
                  ),
                  Space.h12,
                  if (state.persons.isEmpty)
                    EmptyListWidget()
                  else
                    ...state.persons.map(
                          (person) => _PersonCard(
                        person: person,
                        isSubmitting: state.status == EmdadUnitViewStatus.submitting,
                        onDelete: person.id == null
                            ? null
                            : () => _confirmDelete(context, person, cubit),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  List<LookupEntity> _eligiblePersons(EmdadUnitState state) {
    final assignedIds = state.persons
        .map((person) => person.agencyPersonId)
        .whereType<int>()
        .toSet();

    return state.agencyPersons
        .where(
          (person) => !assignedIds.contains(person.id),
    )
        .toList();
  }

/*  List<LookupEntity> _eligiblePersons(EmdadUnitState state) {
    final assignedIds = state.persons
        .map((person) => person.agencyPersonId)
        .whereType<int>()
        .toSet();

    return state.agencyPersons
        .where((person) => !assignedIds.contains(person.id))
        .map((lookup) {
      final matchedPerson = state.persons
          .where(
            (person) => person.agencyPersonId == lookup.id,
      )
          .firstOrNull;

      return LookupEntity(
        id: lookup.id,
        title: matchedPerson?.fullName.trim().isNotEmpty == true
            ? matchedPerson!.fullName.trim()
            : lookup.title,
      );
    })
        .toList();
  }*/

  void _assignPerson(BuildContext context, EmdadUnitCubit cubit) {
    final id = _selectedPersonId;
    if (id == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'انتخاب امدادرسان اجباری می باشد',
      );
      return;
    }
    cubit.assignPerson(id);
  }

  Future<void> _confirmDelete(
      BuildContext context,
      EmdadUnitPersonEntity person,
      EmdadUnitCubit cubit,
      ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: BlocBuilder<EmdadUnitCubit, EmdadUnitState>(
          builder: (context, state) => DeleteConfirmSheet(
            title: 'حذف امدادرسان',
            message: 'آیا از حذف این مورد مطمئن هستید؟ این عمل غیرقابل بازگشت است.',
            confirmTitle: 'حذف',
            isSubmitting: state.status == EmdadUnitViewStatus.submitting,
            onConfirm: () async {
              final ok = await cubit.deletePerson(person.id!);
              if (ok && context.mounted) Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}

class _AddPersonCard extends StatelessWidget {
  const _AddPersonCard({
    required this.selectedPersonId,
    required this.persons,
    required this.isSubmitting,
    required this.onChanged,
    required this.onSubmit,
  });

  final int? selectedPersonId;
  final List<LookupEntity> persons;
  final bool isSubmitting;
  final ValueChanged<int?> onChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final personItems = <String, int>{
      if (persons.isNotEmpty)
        for (final person in persons)
          person.title: person.id
      else
        'انتخاب کنید': -1,
    };

    String? selectedPersonTitle;

    for (final entry in personItems.entries) {
      if (entry.value == selectedPersonId) {
        selectedPersonTitle = entry.key;
        break;
      }
    }

    selectedPersonTitle ??= personItems.keys.first;
    return Container(
      padding: const EdgeInsets.all(AppPadding.p24),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'افزودن امدادرسان',
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          Space.h20,
          IgnorePointer(
            ignoring: isSubmitting,
            child: Opacity(
              opacity: isSubmitting ? 0.6 : 1,
              child: DropDownMapItemsWidget(
                labelText: 'امدادرسان',
                initialValue: selectedPersonTitle,
                mandatory: false,
                items: personItems,
                onChange: (selectedTitle) {
                  onChanged(personItems[selectedTitle]);
                },
              ),
            ),
          ),
          Space.h24,
          InkwellButtonWidget(
            title: 'افزودن',
            showLoading: isSubmitting,
            onTap: selectedPersonId == -1 || isSubmitting ? (){} : onSubmit,
          ),
        ],
      ),
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({
    required this.person,
    required this.isSubmitting,
    required this.onDelete,
  });

  final EmdadUnitPersonEntity person;
  final bool isSubmitting;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppMargin.m12),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.04),
            blurRadius: AppSize.s12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _value(person.fullName),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'حذف',
                onPressed: isSubmitting ? null : onDelete,
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: colorScheme.error,
                ),
              ),
            ],
          ),
          StatusLabel(text: (person.isActive ?? false) ? 'فعال' : 'غیرفعال',
              color: (person.isActive ?? false)
                  ? colorScheme.onError
                  : colorScheme.error),
          Space.h12,
          Divider(height: AppSize.s1, color: Color(0xFFE3E2E2)),
          Space.h12,
          _InfoLine(icon: Icons.badge_outlined, label: 'کد ملی', value: person.nationalNumber),
          _InfoLine(icon: Icons.phone_outlined, label: 'شماره تماس', value: person.mobile),
          _InfoLine(icon: Icons.business_outlined, label: 'نمایندگی', value: person.agencyInfoTitle),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: Row(
        children: [
          Icon(icon, size: AppSize.s16, color: theme.colorScheme.onSurfaceVariant),
          Space.w8,
          Text(
            '$label: ',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Expanded(
            child: Text(
              _value(value),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p6,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: Text(
        '$count مورد',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Text(message, style: theme.textTheme.bodyMedium),
    );
  }
}

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
