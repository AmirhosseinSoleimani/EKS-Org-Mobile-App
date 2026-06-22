import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class AddPartButton extends StatelessWidget {
  final ColorScheme color;
  final VoidCallback onTap;

  const AddPartButton({super.key, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: InkwellButtonWidget(
          width: 124,
          height: 36,
          title: 'افزودن قطعه',
          prefixIcon: Icon(Icons.add, color: color.onTertiaryFixed, size: 18),
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color.onTertiaryFixed,
            fontSize: 13,
          ),
          backgroundColor: Colors.transparent,
          borderColor: color.onTertiaryFixed,
          titleColor: color.onTertiaryFixed,
          onTap: onTap,
        ),
      ),
    );
  }
}
