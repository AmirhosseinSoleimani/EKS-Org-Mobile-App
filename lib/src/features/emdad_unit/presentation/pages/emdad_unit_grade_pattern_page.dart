import 'package:eks_sana_plus_org/src/features/emdad_unit/domain/entities/emdad_unit_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/features/emdad_unit/presentation/widgets/emdad_unit_summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmdadUnitGradePatternPage extends StatefulWidget {
  static const path = '/emdad-unit-grade-pattern-page';
  static const name = 'emdad-unit-grade-pattern-page';

  const EmdadUnitGradePatternPage({super.key, required this.item});

  final EmdadUnitEntity item;

  @override
  State<EmdadUnitGradePatternPage> createState() => _EmdadUnitGradePatternPageState();
}

class _EmdadUnitGradePatternPageState extends State<EmdadUnitGradePatternPage> {
  int? _selectedPatternId;
  int? _selectedServiceType;

  bool get _hasRegisteredPattern {
    return widget.item.gradePatternName?.trim().isNotEmpty == true ||
        widget.item.gradePatternCode != null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
      body: ListView(
        padding: const EdgeInsets.all(AppPadding.p16),
        children: [
          EmdadUnitSummaryCard(item: widget.item),
          Space.h16,
          _FormCard(
            selectedPatternId: _selectedPatternId,
            selectedServiceType: _selectedServiceType,
            onPatternChanged: (value) => setState(() => _selectedPatternId = value),
            onServiceChanged: (value) => setState(() => _selectedServiceType = value),
            onSave: _saveUnsupported,
          ),
          Space.h24,
          Row(
            children: [
              Text(
                'الگوهای ثبت‌شده',
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              _CountBadge(count: _hasRegisteredPattern ? 1 : 0),
            ],
          ),
          Space.h12,
          if (!_hasRegisteredPattern)
            _EmptyCard(message: 'الگوی گریدی برای این واحد ثبت نشده است.')
          else
            _GradePatternCard(
              item: widget.item,
              onDetails: () => _showDetails(context),
              onDelete: () => _showDeleteUnsupported(context),
            ),
        ],
      ),
    );
  }

  void _saveUnsupported() {
    SnakeBarWidget.showError(
      context: context,
      message: 'عملیات ثبت الگوی گرید در قراردادهای فعلی این ویژگی وجود ندارد.',
    );
  }

  void _showDeleteUnsupported(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => EmdadUnitConfirmSheet(
        title: 'حذف الگوی گرید',
        message: 'آیا از حذف این مورد مطمئن هستید؟ این عمل غیرقابل بازگشت است.',
        confirmTitle: 'حذف',
        onConfirm: () async {
          SnakeBarWidget.showError(
            context: context,
            message: 'عملیات حذف الگوی گرید در قراردادهای فعلی این ویژگی وجود ندارد.',
          );
        },
      ),
    );
  }

  void _showDetails(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => _GradePatternDetailsSheet(item: widget.item),
    );
  }
}

class _FormCard extends StatelessWidget {
  const _FormCard({
    required this.selectedPatternId,
    required this.selectedServiceType,
    required this.onPatternChanged,
    required this.onServiceChanged,
    required this.onSave,
  });

  final int? selectedPatternId;
  final int? selectedServiceType;
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
            items: const [],
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
              DropdownMenuItem(value: 2, child: Text('حمل با کفی')),
            ],
            onChanged: onServiceChanged,
          ),
          Space.h32,
          InkwellButtonWidget(
            title: 'ذخیره',
            onTap: onSave,
          ),
        ],
      ),
    );
  }
}

class _GradePatternCard extends StatelessWidget {
  const _GradePatternCard({
    required this.item,
    required this.onDetails,
    required this.onDelete,
  });

  final EmdadUnitEntity item;
  final VoidCallback onDetails;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
                  'کد: ${item.gradePatternCode ?? '---'}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Space.h4,
                Text(
                  'عنوان: ${_value(item.gradePatternName)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Space.h4,
                Text(
                  'نوع خدمت: ${_value(item.typeTitle)}',
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

class _GradePatternDetailsSheet extends StatelessWidget {
  const _GradePatternDetailsSheet({required this.item});

  final EmdadUnitEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final levels = [
      _Level('ممتاز', item.grade == 1),
      _Level('عالی', item.grade == 2),
      _Level('خوب', item.grade == 3),
      _Level('متوسط', item.grade == 4),
      _Level('نیاز به بهبود', item.grade == 5),
      const _Level('در مرز بحران', false),
      const _Level('بحرانی', false, isCritical: true),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: AppSize.s40,
                height: AppSize.s4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
              ),
            ),
            Space.h24,
            Text(
              'جزئیات الگوی گرید',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            Space.h20,
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withOpacity(0.06),
                        blurRadius: AppSize.s16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.grid_view_rounded,
                            size: AppSize.s20,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          Space.w8,
                          Text(
                            'سطوح گرید',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Space.h16,
                      ...levels.map(
                        (level) => _LevelRow(
                          level: level,
                          coefficient: level.isSelected ? item.gradeCoefficient : null,
                          percent: level.isSelected ? item.managmentCommisionPercent : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Space.h16,
            InkwellButtonWidget(
              title: 'بستن',
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelRow extends StatelessWidget {
  const _LevelRow({
    required this.level,
    required this.coefficient,
    required this.percent,
  });

  final _Level level;
  final num? coefficient;
  final num? percent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = level.isCritical ? theme.colorScheme.error : theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.dividerColor.withOpacity(0.55)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            level.title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: level.isCritical ? theme.colorScheme.error : null,
              fontWeight: FontWeight.w800,
            ),
          ),
          Space.h8,
          Wrap(
            spacing: AppSize.s16,
            runSpacing: AppSize.s8,
            children: [
              _Metric(label: 'ضریب گرید', value: coefficient, color: color),
              _Metric(label: 'درصد حق مدیریت', value: percent, color: color),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final num? value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '$label: '),
          TextSpan(
            text: value?.toString() ?? '---',
            style: TextStyle(color: color, fontWeight: FontWeight.w800),
          ),
        ],
      ),
      style: Theme.of(context).textTheme.bodySmall,
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

class _Level {
  const _Level(this.title, this.isSelected, {this.isCritical = false});

  final String title;
  final bool isSelected;
  final bool isCritical;
}

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
