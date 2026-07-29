import 'dart:ui';

import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class DeploymentLocationReportSheet extends StatelessWidget {
  const DeploymentLocationReportSheet({
    super.key,
    required this.records,
  });

  final List<DeploymentLocationEntity> records;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Column(
          children: [
            FullScreenBottomSheetAppBar(
              title: 'گزارش محل‌های استقرار',
              onClose: () => Navigator.of(context).pop(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p12,
                AppPadding.p16,
                AppPadding.p8,
              ),
              child: Row(
                children: [
                  const Icon(Icons.description_outlined),
                  Space.w8,
                  BodyMediumText(
                    text: 'تعداد رکوردها: ${records.length}',
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            Expanded(
              child: records.isEmpty
                  ? const Center(child: EmptyListWidget())
                  : ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.stylus,
                        },
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          AppPadding.p16,
                          AppPadding.p8,
                          AppPadding.p16,
                          AppPadding.p24,
                        ),
                        itemCount: records.length,
                        separatorBuilder: (_, __) => Space.h12,
                        itemBuilder: (context, index) =>
                            _DeploymentLocationReportItem(
                          item: records[index],
                          index: index + 1,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeploymentLocationReportItem extends StatelessWidget {
  const _DeploymentLocationReportItem({
    required this.item,
    required this.index,
  });

  final DeploymentLocationEntity item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppPadding.p14),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: AppSize.s32,
                height: AppSize.s32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: BodySmallText(
                  text: index.toString(),
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Space.w8,
              Expanded(
                child: TitleMediumText(
                  text: item.title ?? '---',
                  fontWeight: FontWeight.w800,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              StatusLabel(
                text: item.isActive == true ? 'فعال' : 'غیرفعال',
                color: item.isActive == true
                    ? theme.colorScheme.onError
                    : theme.colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,
              ),
            ],
          ),
          Space.h12,
          BodySmallText(
            text:
                'استان/شهر: ${item.provinceTitle ?? '---'}/${item.cityTitle ?? '---'}',
            color: theme.colorScheme.onSurfaceVariant,
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
          ),
          Space.h6,
          BodySmallText(
            text: 'آدرس: ${item.address ?? '---'}',
            color: theme.colorScheme.onSurfaceVariant,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
