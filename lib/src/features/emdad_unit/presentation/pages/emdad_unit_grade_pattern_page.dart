import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_summary_card.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/params/grade_pattern_reference_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/cubit/grade_pattern_cubit.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_details_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/drop_down_map_items_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/list_widgets/list_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
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
        bottomNavigationBar: Container(
          decoration:  BoxDecoration(
            color: theme.colorScheme.onPrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: SafeArea(
            minimum: const EdgeInsets.all(AppPadding.p16),
            child: InkwellButtonWidget(
              title: 'بستن',
              backgroundColor: theme.colorScheme.onPrimary,
              borderColor: theme.colorScheme.outline.withOpacity(0.65),
              titleColor: theme.colorScheme.onSurface,
              onTap: () => context.pop(false),
            ),
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
                  ListSectionHeader(
                    title: 'الگوهای ثبت‌شده',
                    countText: '${cubit.references.length} مورد',
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

    BottomSheetMessage.showCustom(
        actionWidget:   InkwellButtonWidget(
          title: 'بستن',
          onTap: () => Navigator.of(context).pop(),
        ),
        context: context, content:
    GradePatternDetailsSheet(item: item)
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
    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      actionWidget: const SizedBox.shrink(),
      isDismissible: false,
      enableDrag: false,
      content: BlocBuilder<GradePatternCubit, GradePatternState>(
        bloc: cubit,
        builder: (sheetContext, state) {
          final isSubmitting = state.maybeWhen(
            submitting: (_, __) => true,
            orElse: () => false,
          );

          return DeleteConfirmSheet(
            title: 'حذف الگوی گرید',
            message:
                'آیا الگوی گرید ${reference.gradePatternName ?? ''} حذف شود؟ این عمل غیرقابل بازگشت است.',
            confirmTitle: 'حذف',
            isSubmitting: isSubmitting,
            onConfirm: () async {
              final deleted = await cubit.deleteReference(id, refId);
              if (deleted && sheetContext.mounted) {
                Navigator.of(sheetContext).pop();
              }
            },
          );
        },
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

  String _getPatternTitle(String? name,
      int id,) {
    final title = name?.trim();

    if (title == null || title.isEmpty) {
      return 'الگوی $id';
    }

    return title;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const defaultPatternTitle = 'انتخاب کنید';

    final patternItems = <String, int>{
      for (final pattern in patterns)
        if (pattern.id != null)
          _getPatternTitle(pattern.name, pattern.id!): pattern.id!,
    };

    if (patternItems.isEmpty) {
      patternItems[defaultPatternTitle] = -1;
    }

    String selectedPatternTitle = defaultPatternTitle;

    for (final entry in patternItems.entries) {
      if (entry.value == selectedPatternId) {
        selectedPatternTitle = entry.key;
        break;
      }
    }

    if (!patternItems.containsKey(selectedPatternTitle)) {
      selectedPatternTitle = patternItems.keys.first;
    }

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Column(
        children: [
          DropDownMapItemsWidget(
            items: patternItems,
            labelText: 'الگو',
            initialValue: selectedPatternTitle,
            mandatory: true,
            onChange: (selectedTitle) {
              final selectedId = patternItems[selectedTitle];

              if (selectedId == null || selectedId == -1) {
                onPatternChanged(null);
                return;
              }

              onPatternChanged(selectedId);
            },
          ),
          Space.h12,
          DropDownMapItemsWidget(
            labelText: 'نوع خدمت',
            initialValue: switch (selectedServiceType) {
              1 => 'خدمات امدادی',
              2 => 'خدمات در محل',
              _ => null,
            },
            mandatory: false,
            items: const {
              'خدمات امدادی': 1,
              'خدمات در محل': 2,
            },
            onChange: (selectedTitle) {
              const serviceTypes = {
                'خدمات امدادی': 1,
                'خدمات در محل': 2,
              };

              onServiceChanged(serviceTypes[selectedTitle]);
            },
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ]
      ),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  BodyMediumText(text:
                    'کد: ${reference.gradePatternCode ?? '---'}',
                  ),
                  Space.w4 ,
                  BodyMediumText(text:
                  '•',
                    color: Color(0xFFDEC1AF),
                  ),
                  Space.w4,
                  BodyMediumText(text:
                    'عنوان: ${_value(reference.gradePatternName)}',
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                  ),
                ],),

                Space.h4,
                BodyMediumText(text:
                  'نوع خدمت: ${_value(reference.serviceTypeTitle)}',
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Space.w12,
          _RoundIconButton(
            icon: Icons.visibility_outlined,
            foreground: Color(0xFF964900),
            background: Color(0xFF964900).withAlpha(25),
            onTap: onDetails,
          ),
          Space.w8,
          _RoundIconButton(
            icon: Icons.delete_outline_rounded,
            foreground: theme.colorScheme.error,
            background: theme.colorScheme.error.withOpacity(0.10),
            onTap: onDelete,
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
