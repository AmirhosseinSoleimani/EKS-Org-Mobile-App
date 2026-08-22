import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_level_form_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class GradePatternForm extends StatefulWidget {
  const GradePatternForm({
    super.key,
    required this.item,
    required this.isSubmitting,
    required this.onSubmit,
    required this.onCancel,
  });

  final GradePatternEntity item;
  final bool isSubmitting;
  final ValueChanged<GradePatternEntity> onSubmit;
  final VoidCallback onCancel;

  @override
  State<GradePatternForm> createState() => _GradePatternFormState();
}

class _GradePatternFormState extends State<GradePatternForm> {
  final _nameController = TextEditingController();
  final _coefficientControllers = <int, TextEditingController>{};
  final _commissionControllers = <int, TextEditingController>{};
  bool _isActive = true;

  bool get _isNew => widget.item.id == null || widget.item.id == 0;

  @override
  void initState() {
    super.initState();
    _syncControllers(widget.item);
  }

  @override
  void didUpdateWidget(covariant GradePatternForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_shouldSync(oldWidget.item, widget.item)) {
      _syncControllers(widget.item);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final controller in _coefficientControllers.values) {
      controller.dispose();
    }
    for (final controller in _commissionControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      appBar: SimpleAppBar(
        title: _isNew ? 'افزودن الگوی گرید' : 'ویرایش الگوی گرید',
      ),
      bottomNavigationBar: _GradePatternFormActions(
        isNew: _isNew,
        isSubmitting: widget.isSubmitting,
        onSubmit: _submit,
        onCancel: widget.onCancel,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p24,
          AppPadding.p16,
          AppPadding.p24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormFieldWidget(
              controller: _nameController,
              labelText: 'عنوان',
            ),
            Space.h24,
            Text(
              'تعیین مقادیر سطوح',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF574235),
                  ),
            ),
            Space.h16,
            ...widget.item.details.map(_buildDetailEditor),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailEditor(GradePatternDetailEntity detail) {
    final coefficientController = _coefficientControllers.putIfAbsent(
      detail.gradeId,
          () => TextEditingController(
        text: _initialNumberText(detail.gradeCoefficient),
      ),
    );

    final commissionController = _commissionControllers.putIfAbsent(
      detail.gradeId,
          () => TextEditingController(
        text: _initialNumberText(detail.managmentCommisionPercent),
      ),
    );

    return GradePatternLevelFormCard(
      detail: detail,
      coefficientController: coefficientController,
      commissionController: commissionController,
    );
  }

  String _initialNumberText(num value) {
    if (!_isNew) return value.toString();
    return value == 0 ? '' : value.toString();
  }

  void _submit() {
    final details = widget.item.details.map((detail) {
      return detail.copyWith(
        gradeCoefficient: num.tryParse(
              _coefficientControllers[detail.gradeId]?.text.trim() ?? '',
            ) ??
            0,
        managmentCommisionPercent: num.tryParse(
              _commissionControllers[detail.gradeId]?.text.trim() ?? '',
            ) ??
            0,
      );
    }).toList();

    widget.onSubmit(widget.item.copyWith(
      name: _nameController.text.trim(),
      isActive: _isActive,
      details: details,
    ));
  }

  void _syncControllers(GradePatternEntity item) {
    _nameController.text = item.name ?? '';
    _isActive = item.isActive;

    final gradeIds = item.details.map((detail) => detail.gradeId).toSet();
    _disposeRemovedControllers(_coefficientControllers, gradeIds);
    _disposeRemovedControllers(_commissionControllers, gradeIds);

    for (final detail in item.details) {
      _setControllerText(
        _coefficientControllers,
        detail.gradeId,
        _initialNumberText(detail.gradeCoefficient),
      );

      _setControllerText(
        _commissionControllers,
        detail.gradeId,
        _initialNumberText(detail.managmentCommisionPercent),
      );
    }
  }

  void _disposeRemovedControllers(
    Map<int, TextEditingController> controllers,
    Set<int> gradeIds,
  ) {
    final removedIds = controllers.keys
        .where((gradeId) => !gradeIds.contains(gradeId))
        .toList(growable: false);
    for (final gradeId in removedIds) {
      controllers.remove(gradeId)?.dispose();
    }
  }

  void _setControllerText(
    Map<int, TextEditingController> controllers,
    int gradeId,
    String value,
  ) {
    final controller = controllers.putIfAbsent(
      gradeId,
      () => TextEditingController(),
    );
    controller.text = value;
  }

  bool _shouldSync(GradePatternEntity oldItem, GradePatternEntity newItem) {
    return oldItem.id != newItem.id ||
        oldItem.details.length != newItem.details.length;
  }
}

class _GradePatternFormActions extends StatelessWidget {
  const _GradePatternFormActions({
    required this.isNew,
    required this.isSubmitting,
    required this.onSubmit,
    required this.onCancel,
  });

  final bool isNew;
  final bool isSubmitting;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(14),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Row(
            children: [
              Expanded(
                child: InkwellButtonWidget(
                  title: isNew ? 'افزودن' : 'ثبت تغییرات',
                  showLoading: isSubmitting,
                  borderRadius: AppSize.s8,
                  onTap: () {
                    if (isSubmitting) return;
                    onSubmit();
                  },
                ),
              ),
              Space.w12,
              Expanded(
                child: InkwellButtonWidget(
                  title: 'انصراف',
                  backgroundColor: theme.colorScheme.onPrimary,
                  titleColor: theme.colorScheme.onSurfaceVariant,
                  borderRadius: AppSize.s8,
                  onTap: () {
                    if (isSubmitting) return;
                    onCancel();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
