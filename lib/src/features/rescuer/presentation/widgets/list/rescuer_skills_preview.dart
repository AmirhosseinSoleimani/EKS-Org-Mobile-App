import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RescuerSkillsPreview extends StatelessWidget {
  final String? certificatesTitle;

  const RescuerSkillsPreview({super.key, required this.certificatesTitle});

  @override
  Widget build(BuildContext context) {
    final titles = _parseTitles(certificatesTitle);
    if (titles.isEmpty) return const SizedBox.shrink();

    final visibleTitles = titles.take(2).toList(growable: false);
    final hiddenCount = titles.length - visibleTitles.length;

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        SvgWidget(src: SvgAsset(SvgManager.rescuerOperations)),
        ...visibleTitles.map(
          (title) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
            ),
            child: BodySmallText(
              text: title,
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        if (hiddenCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE9DD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: BodySmallText(
              text: '+ $hiddenCount مورد دیگر',
              fontSize: 11,
              color: const Color(0xFFF97316),
            ),
          ),
      ],
    );
  }

  List<String> _parseTitles(String? source) {
    final value = source?.trim();
    if (value == null || value.isEmpty) return const [];

    return value
        .split(RegExp(r'[,،;|]'))
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }
}
