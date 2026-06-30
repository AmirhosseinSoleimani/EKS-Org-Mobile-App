import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
class ColoredInfoCardItem {
  final String? title;
  final String value;
  final bool spaceBetween;
  final FontWeight? valueFontWeight;

  const ColoredInfoCardItem({
    this.title,
    required this.value,
    this.spaceBetween = false,
    this.valueFontWeight,
  });

  const ColoredInfoCardItem.row({
    required String title,
    required String value,
  }) : this(
    title: title,
    value: value,
    spaceBetween: true,
    valueFontWeight: FontWeight.bold,
  );

  const ColoredInfoCardItem.text({
    required String value,
    FontWeight? fontWeight,
  }) : this(
    value: value,
    spaceBetween: false,
    valueFontWeight: fontWeight,
  );
}
class ColoredInfoCard extends StatelessWidget {
  final String title;
  final List<ColoredInfoCardItem> items;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color? itemColor;

  const ColoredInfoCard({
    super.key,
    required this.title,
    required this.items,
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    this.itemColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveItemColor = itemColor ?? titleColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyMediumText(
            text: title,
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),

          if (items.isNotEmpty) ...[
            const SizedBox(height: 12),

            ...List.generate(items.length, (index) {
              final item = items[index];

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == items.length - 1 ? 0 : 8,
                ),
                child: _ColoredInfoCardItemView(
                  item: item,
                  textColor: effectiveItemColor,
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}

class _ColoredInfoCardItemView extends StatelessWidget {
  final ColoredInfoCardItem item;
  final Color textColor;

  const _ColoredInfoCardItemView({
    required this.item,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    if (item.spaceBetween && item.title != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BodySmallText(
            text: item.title!,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          BodySmallText(
            text: item.value,
            fontWeight: item.valueFontWeight ?? FontWeight.bold,
            color: textColor,
          ),
        ],
      );
    }

    return BodySmallText(
      text: item.value,
      color: textColor,
      fontWeight: item.valueFontWeight ?? FontWeight.w500,
    );
  }
}