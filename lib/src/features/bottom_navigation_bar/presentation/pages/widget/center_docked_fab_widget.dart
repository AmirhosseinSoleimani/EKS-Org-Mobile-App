import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';

class CenterDockedFabWidget extends StatelessWidget {
  const CenterDockedFabWidget({super.key, required this.onPressed});

  final void Function(BuildContext) onPressed;
  static const double outer = 64;
  static const double ring = 6;
  static const double inner = outer - (ring * 2);

  static double get innerRadius => inner / 2;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ringColor = colorScheme.onPrimary;
    return GestureDetector(
      onTap: () => onPressed(context),
      child: SizedBox(
        width: outer,
        height: outer,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: ringColor,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(ring),
            child: Container(
              decoration: BoxDecoration(
                  color: colorScheme.primary, shape: BoxShape.circle),
              child: Center(
                child: SvgWidget(
                  src: const SvgAsset(SvgManager.electricBolt),
                  width: AppSize.s24,
                  height: AppSize.s24,
                  color: colorScheme.onPrimary,
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
