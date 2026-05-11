import 'package:eks_sana_plus_org/src/common/constants/gender.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class GenderSelectorWidget extends StatelessWidget {
  final ValueListenable<Gender?> selectedListenable;
  final ValueChanged<Gender> onChanged;

  const GenderSelectorWidget({
    super.key,
    required this.selectedListenable,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Gender?>(
      valueListenable: selectedListenable,
      builder: (_, selected, _) {
        return Row(
          children: [
            Expanded(
              child: _GenderButton(
                gender: Gender.male,
                selected: selected == Gender.male,
                onTap: selected == Gender.male
                    ? null
                    : () => onChanged(Gender.male),
              ),
            ),
            Space.w16,
            Expanded(
              child: _GenderButton(
                gender: Gender.female,
                selected: selected == Gender.female,
                onTap: selected == Gender.female
                    ? null
                    : () => onChanged(Gender.female),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GenderButton extends StatelessWidget {
  final Gender gender;
  final bool selected;
  final VoidCallback? onTap;

  const _GenderButton({
    required this.gender,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: AnimatedContainer(
        duration: DurationConstant.d200,
        curve: Curves.easeOut,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(AppPadding.p12),
        decoration: BoxDecoration(
          color: selected ? cs.primary.withOpacity(0.2) : cs.onPrimary,
          borderRadius: BorderRadius.circular(AppSize.s12),
          border: Border.all(
            width: AppSize.s2,
            color: selected ? cs.primary : cs.onSecondaryFixed,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            gender.label.labelMedium(context),
            Space.w4,
            SvgWidget(
              src: SvgAsset(gender.icon),
              width: AppSize.s24,
              height: AppSize.s24,
            ),
          ],
        ),
      ),
    );
  }
}
