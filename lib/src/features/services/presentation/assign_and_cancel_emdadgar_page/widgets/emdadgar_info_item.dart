import 'package:eks_sana_plus_org/src/common/utils/car_plate_parser.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/car_plate.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class EmdadgarInfoItem extends StatelessWidget {
  final EmdadgarEntity entity;

  const EmdadgarInfoItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final brief = entity.emdadgars?.isNotEmpty == true
        ? entity.emdadgars!.first
        : null;

    final mobile = entity.planAidPeople?.isNotEmpty == true
        ? entity.planAidPeople!.first.mobile ?? ""
        : "";

    final plateText = CarPlateParser.parse(entity.plakText ?? "");

    return Stack(
      children: [
        Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleLargeText(text: brief?.aidPerName ?? ""),
                  Container(
                    width: 36,
                    height: 36,
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

              Space.h8,

              Row(
                children: [
                  Icon(Icons.location_on, size: 18, color: colorScheme.outline),
                  Space.w8,
                  BodyMediumText(
                    text:
                        '${entity.ostanNamayandegiText ?? ""}، ${entity.shahrNamayandegiText ?? ""}',
                  ),
                ],
              ),

              Space.h8,

              Row(
                children: [
                  Icon(
                    Icons.local_shipping,
                    size: 18,
                    color: colorScheme.outline,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: BodyMediumText(
                      text:
                          '${entity.navganTypeText ?? ""} - ${entity.khodroTypeText ?? ""}',
                    ),
                  ),
                ],
              ),

              Space.h8,
              BodyMediumText(text: "نمایندگی: ${entity.agencyName ?? ""}"),
              Space.h8,
              BodyMediumText(text: "شماره تماس: $mobile"),
              Space.h8,
              BodyMediumText(text: "نوع شیفت: ${entity.shiftTypeText ?? ""}"),
              Space.h8,
              BodyMediumText(text: "برنامه‌ریزی: ${entity.tarhNameText ?? ""}"),
              Space.h8,
              BodyMediumText(
                text:
                    "فاصله: ${entity.distanceKmToOrigin?.toStringAsFixed(1) ?? ""} کیلومتر | زمان:",
              ),
            ],
          ),
        ),
        Positioned(
          top: 68,
          left: 16,
          child: SizedBox(
            width: 120,
            height: 28,
            child: CarPlate(
              firstCarTag: plateText.first,
              secondCarTag: plateText.second,
              thirdCarTag: plateText.third,
              fourthCarTag: plateText.fourth,
              textStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: AppSize.s12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
