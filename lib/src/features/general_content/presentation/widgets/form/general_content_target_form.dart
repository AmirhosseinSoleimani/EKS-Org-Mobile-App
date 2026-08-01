import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_target_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/cubit/general_content_state.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_submit_controller.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_target_form_section.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';

class GeneralContentTargetForm extends StatefulWidget {
  const GeneralContentTargetForm({
    super.key,
    required this.content,
    required this.state,
    required this.submitController,
    required this.onTargetTypeChanged,
    required this.onSubmit,
    required this.onSuccess,
  });

  final GeneralContentEntity content;
  final GeneralContentState state;
  final GeneralContentSubmitController submitController;
  final ValueChanged<int?> onTargetTypeChanged;
  final Future<bool> Function(GeneralContentTargetParamEntity param) onSubmit;
  final VoidCallback onSuccess;

  @override
  State<GeneralContentTargetForm> createState() =>
      _GeneralContentTargetFormState();
}

class _GeneralContentTargetFormState extends State<GeneralContentTargetForm> {
  final _formKey = GlobalKey<FormState>();

  int? _selectedTargetType;
  int? _selectedTargetCategory;
  int? _selectedBoundaryType;
  int? _selectedOperatorType;

  @override
  void initState() {
    super.initState();
    _selectedBoundaryType = _firstValue(widget.state.targetBoundaryTypeOptions);
    _selectedOperatorType = _firstValue(widget.state.logicalOperatorTypeOptions);
    widget.submitController.attach(_submit);
  }

  @override
  void didUpdateWidget(covariant GeneralContentTargetForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.submitController != widget.submitController) {
      oldWidget.submitController.detach(_submit);
      widget.submitController.attach(_submit);
    }

    _selectedBoundaryType ??=
        _firstValue(widget.state.targetBoundaryTypeOptions);
    _selectedOperatorType ??=
        _firstValue(widget.state.logicalOperatorTypeOptions);
  }

  @override
  void dispose() {
    widget.submitController.detach(_submit);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p24,
          AppPadding.p16,
          AppPadding.p32,
        ),
        children: [
          GeneralContentTargetFormSection(
            targetTypes: widget.state.targetTypeOptions,
            targetCategories: widget.state.targetCategoryOptions,
            boundaryTypes: widget.state.targetBoundaryTypeOptions,
            operatorTypes: widget.state.logicalOperatorTypeOptions,
            selectedTargetType: _selectedTargetType,
            selectedTargetCategory: _selectedTargetCategory,
            selectedBoundaryType: _selectedBoundaryType,
            selectedOperatorType: _selectedOperatorType,
            onTargetTypeChanged: (value) {
              setState(() {
                _selectedTargetType = value;
                _selectedTargetCategory = null;
              });
              widget.onTargetTypeChanged(value);
            },
            onTargetCategoryChanged: (value) {
              setState(() => _selectedTargetCategory = value);
            },
            onBoundaryTypeChanged: (value) {
              setState(() => _selectedBoundaryType = value);
            },
            onOperatorTypeChanged: (value) {
              setState(() => _selectedOperatorType = value);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final contentId = widget.content.id;
    final targetType = _selectedTargetType;
    final categoryId = _selectedTargetCategory;
    final boundaryType = _selectedBoundaryType;
    final operatorType = _selectedOperatorType;

    if (contentId == null) {
      SnakeBarWidget.showError(
        context: context,
        message: 'شناسه بخشنامه برای افزودن گیرنده یافت نشد.',
      );
      return;
    }

    if (targetType == null ||
        categoryId == null ||
        boundaryType == null ||
        operatorType == null) {
      return;
    }

    final success = await widget.onSubmit(
      GeneralContentTargetParamEntity(
        generalContentId: contentId,
        operatorType: operatorType,
        targetCategoryIds: <int>[categoryId],
        targetBoundaryType: boundaryType,
        targetType: targetType,
      ),
    );

    if (success && mounted) {
      widget.onSuccess();
    }
  }

  int? _firstValue(List<CurrentSessionEnumItemEntity> items) {
    for (final item in items) {
      final value = item.value;
      if (value != null) return value;
    }
    return null;
  }
}
