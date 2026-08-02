import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class DeploymentLocationCard extends StatelessWidget {
  const DeploymentLocationCard({
    super.key,
    required this.item,
    required this.onActions,
    this.isActionLoading = false,
  });

  final DeploymentLocationEntity item;
  final VoidCallback onActions;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppSummaryCard(
      title: item.title ?? '---',
      leading: _LocationIcon(color: theme.colorScheme.primary),
      badges: [
        StatusLabel(
          text: item.isActive == true ? 'فعال' : 'غیرفعال',
          color: item.isActive == true
              ? theme.colorScheme.onError
              : theme.colorScheme.error,
          variant: StatusLabelVariant.filledWithoutBorder,
        ),
      ],
      infoItems: [
        SummaryCardInfo(
          icon: Icons.map_outlined,
          label: 'استان/شهر',
          value: '${item.provinceTitle ?? '---'}/${item.cityTitle ?? '---'}',
        ),
        SummaryCardInfo(
          icon: Icons.location_on_outlined,
          label: 'آدرس',
          value: item.address,
          maxLines: 2,
        ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertFullName,
          date: item.insertDateTimeJalali,
          dateTextDirection: TextDirection.ltr,
        ),
      ],
      onOperation: onActions,
      isOperationLoading: isActionLoading,
    );
  }
}

class _LocationIcon extends StatelessWidget {
  const _LocationIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s48,
      height: AppSize.s48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.location_on_outlined,
        color: color,
        size: AppSize.s28,
      ),
    );
  }
}
