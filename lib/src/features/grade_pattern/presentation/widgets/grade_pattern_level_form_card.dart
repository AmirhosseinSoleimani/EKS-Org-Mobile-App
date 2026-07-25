import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_level_style.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GradePatternLevelFormCard extends StatelessWidget {
  const GradePatternLevelFormCard({
    super.key,
    required this.detail,
    required this.coefficientController,
    required this.commissionController,
  });

  final GradePatternDetailEntity detail;
  final TextEditingController coefficientController;
  final TextEditingController commissionController;

  static final List<TextInputFormatter> _percentInputFormatters = [
    _MaxHundredDecimalInputFormatter(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = gradePatternLevelStyle(detail.gradeTitle);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border(
          right: BorderSide(color: style.color, width: 4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p16,
          AppPadding.p16,
          14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                style.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: style.color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Space.h16,
            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    controller: coefficientController,
                    labelText: 'ضریب',
                    textInputType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    textInputFormatter: _percentInputFormatters,
                  ),
                ),
                Space.w16,
                Expanded(
                  child: TextFormFieldWidget(
                    controller: commissionController,
                    labelText: 'درصد حق مدیریت',
                    textInputType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    textInputFormatter: _percentInputFormatters,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MaxHundredDecimalInputFormatter extends TextInputFormatter {
  final _validNumberPattern = RegExp(r'^\d{0,3}(\.\d*)?$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.trim();
    if (text.isEmpty) return newValue;
    if (!_validNumberPattern.hasMatch(text)) return oldValue;

    final value = num.tryParse(text);
    if (value == null || value > 100) return oldValue;

    return newValue;
  }
}
