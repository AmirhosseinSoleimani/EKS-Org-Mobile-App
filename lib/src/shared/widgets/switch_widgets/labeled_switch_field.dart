import 'package:flutter/material.dart';

import '../text_widgets/body_medium_text.dart';

class LabeledSwitchField extends StatelessWidget {
  const LabeledSwitchField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.labelFontWeight = FontWeight.w600,
    this.inactiveTrackColor = const Color(0xFFD1D1D1),
    this.activeTrackColor,
    this.activeThumbColor,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final FontWeight labelFontWeight;
  final Color inactiveTrackColor;
  final Color? activeTrackColor;
  final Color? activeThumbColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: BodyMediumText(
            text: label,
            fontWeight: labelFontWeight,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          inactiveTrackColor: inactiveTrackColor,
          inactiveThumbColor: colorScheme.onPrimary,
          activeTrackColor: activeTrackColor ?? colorScheme.primary,
          activeThumbColor: activeThumbColor ?? colorScheme.onPrimary,

          trackOutlineColor: const MaterialStatePropertyAll<Color>(
            Colors.transparent,
          ),
        ),
      ],
    );
  }
}