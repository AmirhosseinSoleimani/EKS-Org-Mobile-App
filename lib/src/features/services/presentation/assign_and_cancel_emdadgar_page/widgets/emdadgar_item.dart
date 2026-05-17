import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class EmdadgarItem extends StatelessWidget {
  final EmdadgarEntity entity;

  const EmdadgarItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final brief = entity.emdadgars?.isNotEmpty == true
        ? entity.emdadgars!.first
        : null;

    final daily = brief?.report?.daily;
    final weekly = brief?.report?.weekly;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface.withAlpha(150),
        border: Border.all(color: colorScheme.onInverseSurface),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleLargeText(text: brief?.aidPerName ?? ""),
                    Space.h16,
                    StatusLabel(
                      text: entity.statusTitle ?? '',
                      fontSize: 12,
                      backgroundColor: Color(0xFFfff8e1),
                      color: (entity.status == 1)
                          ? colorScheme.onError
                          : Color(0xFFc8a763),
                    ),
                  ],
                ),
              ),

              Container(
                width: 36,
                height: 36,
                margin: EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorLightManager.success,
                ),
                child: TitleLargeText(
                  text: "${entity.priority ?? 0}",
                  color: colorScheme.onError,
                ),
              ),
            ],
          ),

          Space.h12,

          Row(
            children: [
              Icon(Icons.location_on, color: colorScheme.outline),
              Space.w8,
              BodyMediumText(
                text:
                    '${entity.ostanNamayandegiText ?? ""}، ${entity.shahrNamayandegiText ?? ""}',
              ),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              const Icon(Icons.local_shipping, size: 18),
              const SizedBox(width: 6),
              Expanded(child:   BodyMediumText(text: entity.khodroTypeText ?? "")),
            ],
          ),

          const SizedBox(height: 6),
          BodyMediumText(text: "نمایندگی: ${entity.agencyName ?? ""}"),
          const SizedBox(height: 4),
          BodyMediumText(text:  "فاصله: ${entity.distanceKmToOrigin?.toStringAsFixed(1) ?? ""} کیلومتر | زمان:"),

          const SizedBox(height: 6),

          BodyMediumText(text:
            "ماموریت امروز: ${daily?.successCount ?? 0} | هفته اخیر: ${weekly?.successCount ?? 0}",
          ),

          Space.h16,
          Row(
            children: [
              Expanded(
                child: InkwellButtonWidget(
                  onTap: () {},
                  title: "تخصیص",
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(

                child: InkwellButtonWidget(
                  backgroundColor: Colors.transparent,
                  borderColor: Color(0xFFf6c972),
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Color(0xFFae8129)),
                  title: "عدم همکاری",
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
