import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:flutter/material.dart';

class VehicleModelCard extends StatelessWidget {
  const VehicleModelCard({
    super.key,
    required this.item,
    required this.onActions,
    this.isActionLoading = false,
  });

  final VehicleModelEntity item;
  final VoidCallback onActions;
  final bool isActionLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppSummaryCard(
      title: item.name ?? item.title ?? '---',
      subtitle: 'کد: ${item.code ?? '---'}',
      leading: CircleAvatar(
        radius: AppSize.s28,
        backgroundColor: theme.colorScheme.primary.withAlpha(25),
        child: SvgWidget(src: SvgAsset(SvgManager.autoTowing)),
      ),
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
          icon: Icons.commute,
          label: 'نوع ناوگان',
          value: item.navganTypeTitle,
        ),
        SummaryCardInfo(
          icon: Icons.inventory_2_outlined,
          label: 'مجهز به انبارک',
          value: item.hasDepot == true ? 'بله' : 'خیر',
        ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: item.insertDateTimeJalali,
        ),
      ],
      onOperation: onActions,
      isOperationLoading: isActionLoading,
    );
  }
}
