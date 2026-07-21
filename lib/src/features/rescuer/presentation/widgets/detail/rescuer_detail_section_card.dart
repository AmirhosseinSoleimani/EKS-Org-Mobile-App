import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class RescuerDetailSectionCard extends StatelessWidget {
  final String title;
  final String icon;
  final List<Widget> children;

  const RescuerDetailSectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgWidget(src: SvgAsset(icon)),
              const SizedBox(width: 8),
              BodyMediumText(
                text: title,
                color: const Color(0xFFF97316),
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

class RescuerDetailInfoGrid extends StatelessWidget {
  final List<RescuerDetailInfoItem> items;

  const RescuerDetailInfoGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      children: items
          .map((item) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width > 360
                  ? (MediaQuery.sizeOf(context).width - 88) / 2
                  : double.infinity,
              child: item,
            );
          })
          .toList(growable: false),
    );
  }
}

class RescuerDetailInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const RescuerDetailInfoItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyMediumText(
          text: label,
          color: Color(0xFF574235),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        BodyMediumText(
          text: value,
          textAlign: TextAlign.right,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          lineHeight: 1.55,
        ),
      ],
    );
  }
}

class RescuerContactTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const RescuerContactTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3F3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.onSurfaceVariant, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyMediumText(
                  text: title,
                  color: Color(0xFF574235),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 6),
                BodyMediumText(
                  text: value,
                  textAlign: TextAlign.right,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
