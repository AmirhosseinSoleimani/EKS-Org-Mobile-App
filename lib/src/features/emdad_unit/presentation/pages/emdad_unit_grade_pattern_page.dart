import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_summary_card.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/params/grade_pattern_reference_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/cubit/grade_pattern_cubit.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_details_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmdadUnitGradePatternPage extends StatelessWidget {
  static const path = '/emdad-unit-grade-pattern-page';
  static const name = 'emdad-unit-grade-pattern-page';

  const EmdadUnitGradePatternPage({super.key, required this.item});

  final EmdadUnitEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GradePatternCubit>()
        ..loadActivePatterns()
        ..loadReferences(item.id ?? 0),
      child: _EmdadUnitGradePatternView(item: item),
    );
  }
}

class _EmdadUnitGradePatternView extends StatefulWidget {
  const _EmdadUnitGradePatternView({required this.item});

  final EmdadUnitEntity item;

  @override
  State<_EmdadUnitGradePatternView> createState() =>
      _EmdadUnitGradePatternViewState();
}

class _EmdadUnitGradePatternViewState
    extends State<_EmdadUnitGradePatternView> {
  static const int _emdadUnitReferenceType = 1;
  int? _selectedPatternId;
  int? _selectedServiceType;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GradePatternCubit>();
    final theme = Theme.of(context);

    return BlocListener<GradePatternCubit, GradePatternState>(
      listener: (context, state) {
        state.whenOrNull(
          failure: (message, items) {
            SnakeBarWidget.showError(context: context, message: message);
          },
          success: (action, message, items) {
            SnakeBarWidget.showSuccess(context: context, message: message);
          },
        );
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const SimpleAppBar(title: 'الگوی گرید'),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.all(AppPadding.p16),
          child: InkwellButtonWidget(
            title: 'بستن',
            backgroundColor: theme.colorScheme.onPrimary,
            borderColor: theme.colorScheme.outline.withOpacity(0.65),
            titleColor: theme.colorScheme.onSurface,
            onTap: () => context.pop(false),
          ),
        ),
        body: BlocBuilder<GradePatternCubit, GradePatternState>(
          builder: (context, state) {
            final isSubmitting = state.maybeWhen(
              submitting: (_, __) => true,
              orElse: () => false,
            );
            return RefreshIndicator(
              onRefresh: () => cubit.loadReferences(widget.item.id ?? 0),
              child: ListView(
                padding: const EdgeInsets.all(AppPadding.p16),
                children: [
                  EmdadUnitSummaryCard(item: widget.item),
                  Space.h16,
                  _AssignCard(
                    patterns: cubit.activePatterns,
                    selectedPatternId: _selectedPatternId,
                    selectedServiceType: _selectedServiceType,
                    isSubmitting: isSubmitting,
                    onPatternChanged: (value) {
                      setState(() => _selectedPatternId = value);
                    },
                    onServiceChanged: (value) {
                      setState(() => _selectedServiceType = value);
                    },
                    onSave: () => _assign(cubit),
                  ),
                  Space.h24,
                  Row(
                    children: [
                      Text(
                        'الگوهای ثبت‌شده',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      _CountBadge(count: cubit.references.length),
                    ],
                  ),
                  Space.h12,
                  if (cubit.references.isEmpty)
                    _EmptyCard(message: 'الگوی گریدی برای این واحد ثبت نشده است.')
                  else
                    ...cubit.references.map(
                          (reference) => _ReferenceCard(
                        reference: reference,
                        onDetails: () => _showDetails(context, cubit, reference),
                        onDelete: () => _showDelete(context, cubit, reference),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _assign(GradePatternCubit cubit) async {
    final refId = widget.item.id;
    if (_selectedPatternId == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'انتخاب الگوی گرید اجباری می باشد',
      );
      return;
    }
    if (_selectedServiceType == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'نوع خدمت اجباری می باشد',
      );
      return;
    }
    if (refId == null) return;

    final ok = await cubit.assignReference(
      GradePatternReferenceParamEntity(
        gradePatternId: _selectedPatternId!,
        serviceTypeId: _selectedServiceType!,
        refType: _emdadUnitReferenceType,
        refId: refId,
      ),
    );
    if (ok) {
      setState(() {
        _selectedPatternId = null;
        _selectedServiceType = null;
      });
    }
  }

  Future<void> _showDetails(
      BuildContext context,
      GradePatternCubit cubit,
      GradePatternReferenceEntity reference,
      ) async {
    final id = reference.gradePatternId;
    if (id == null) return;
    await cubit.loadDetail(id);
    final item = cubit.state.whenOrNull(detailLoaded: (item) => item);
    if (item == null || !context.mounted) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => GradePatternDetailsSheet(item: item),
    );
  }

  void _showDelete(
      BuildContext context,
      GradePatternCubit cubit,
      GradePatternReferenceEntity reference,
      ) {
    final id = reference.id;
    final refId = widget.item.id;
    if (id == null || refId == null) return;
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => GradePatternConfirmSheet(
        title: 'حذف الگوی گرید',
        message: 'آیا الگوی گرید ${reference.gradePatternName ?? ''} حذف شود؟',
        onConfirm: () => cubit.deleteReference(id, refId),
      ),
    );
  }
}

class _AssignCard extends StatelessWidget {
  const _AssignCard({
    required this.patterns,
    required this.selectedPatternId,
    required this.selectedServiceType,
    required this.isSubmitting,
    required this.onPatternChanged,
    required this.onServiceChanged,
    required this.onSave,
  });

  final List<GradePatternEntity> patterns;
  final int? selectedPatternId;
  final int? selectedServiceType;
  final bool isSubmitting;
  final ValueChanged<int?> onPatternChanged;
  final ValueChanged<int?> onServiceChanged;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Column(
        children: [
          DropdownButtonFormField<int>(
            value: selectedPatternId,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'الگوی گرید',
              hintText: 'انتخاب کنید',
            ),
            items: patterns
                .where((item) => item.id != null)
                .map(
                  (item) => DropdownMenuItem(
                value: item.id,
                child: Text(item.name ?? '---'),
              ),
            )
                .toList(),
            onChanged: onPatternChanged,
          ),
          Space.h12,
          DropdownButtonFormField<int>(
            value: selectedServiceType,
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'نوع خدمت',
              hintText: 'انتخاب کنید',
            ),
            items: const [
              DropdownMenuItem(value: 1, child: Text('خدمات امدادی')),
              DropdownMenuItem(value: 2, child: Text('خدمات در محل')),
            ],
            onChanged: onServiceChanged,
          ),
          Space.h24,
          InkwellButtonWidget(
            title: 'ذخیره',
            showLoading: isSubmitting,
            onTap: onSave,
          ),
        ],
      ),
    );
  }
}

class _ReferenceCard extends StatelessWidget {
  const _ReferenceCard({
    required this.reference,
    required this.onDetails,
    required this.onDelete,
  });

  final GradePatternReferenceEntity reference;
  final VoidCallback onDetails;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppPadding.p12),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Row(
        children: [
          _RoundIconButton(
            icon: Icons.delete_outline_rounded,
            foreground: theme.colorScheme.error,
            background: theme.colorScheme.error.withOpacity(0.10),
            onTap: onDelete,
          ),
          Space.w8,
          _RoundIconButton(
            icon: Icons.visibility_outlined,
            foreground: theme.colorScheme.primary,
            background: theme.colorScheme.primary.withOpacity(0.10),
            onTap: onDetails,
          ),
          Space.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'کد: ${reference.gradePatternCode ?? '---'}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Space.h4,
                Text(
                  'عنوان: ${_value(reference.gradePatternName)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Space.h4,
                Text(
                  'نوع خدمت: ${_value(reference.serviceTypeTitle)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.foreground,
    required this.background,
    required this.onTap,
  });

  final IconData icon;
  final Color foreground;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s24),
      onTap: onTap,
      child: Container(
        width: AppSize.s40,
        height: AppSize.s40,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(icon, color: foreground, size: AppSize.s20),
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
        horizontal: AppPadding.p10,
        vertical: AppPadding.p4,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.10),
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
