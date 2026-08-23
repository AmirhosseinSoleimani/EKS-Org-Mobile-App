import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class TwoTextFieldsRow extends StatelessWidget {
  final TextEditingController firstController;
  final TextEditingController secondController;

  final String? firstLabel;
  final String? firstHint;

  final String? secondLabel;
  final String? secondHint;

  final TextInputType? firstKeyboardType;
  final TextInputType? secondKeyboardType;

  const TwoTextFieldsRow({
    super.key,
    required this.firstController,
    required this.secondController,
    this.firstLabel,
    this.firstHint,
    this.secondLabel,
    this.secondHint,
    this.firstKeyboardType,
    this.secondKeyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormFieldWidget(
            controller: firstController,
            labelText: firstLabel,
            hintText: firstHint,
            textInputType: firstKeyboardType,
          ),
        ),
        Space.w16,
        Expanded(
          child: TextFormFieldWidget(
            controller: secondController,
            labelText: secondLabel,
            hintText: secondHint,
            textInputType: secondKeyboardType,
          ),
        ),
      ],
    );
  }
}
