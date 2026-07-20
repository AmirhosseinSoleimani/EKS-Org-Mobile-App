import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

import 'svg_widget/svg_src.dart';
import 'svg_widget/svg_widget.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SvgWidget(
          src: SvgAsset(SvgManager.emptyList),
        ),
        Space.h16,
        TitleMediumText(
          text: 'هیچ موردی جهت نمایش وجود ندارد',
          color: Theme.of(context).colorScheme.onPrimaryFixed,
          fontSize: AppSize.s14,
        )
      ],
    );
  }
}
