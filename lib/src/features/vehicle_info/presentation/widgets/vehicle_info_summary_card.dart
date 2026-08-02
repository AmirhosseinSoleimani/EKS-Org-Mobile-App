import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/vehicle_license_plate_view.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class VehicleInfoSummaryCard extends StatelessWidget {
  const VehicleInfoSummaryCard({
    super.key,
    required this.item,
    this.onTap,
    this.onTools,
    this.onServices,
    this.onDelete,
    this.onHistory,
  });

  final VehicleInfoEntity item;
  final VoidCallback? onTap;
  final VoidCallback? onTools;
  final VoidCallback? onServices;
  final VoidCallback? onDelete;
  final VoidCallback? onHistory;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final plate = item.licensePlate?.trim();

    return AppSummaryCard(
      title: item.title,
      onTap: onTap,
      badges: [
        StatusLabel(
          text: item.vehicleStatusTitle ?? '',
          color: item.isActive == true
              ? theme.colorScheme.onError
              : theme.colorScheme.error,
          variant: StatusLabelVariant.filledWithoutBorder,
        ),
      ],
      beforeInfo: plate != null && plate.isNotEmpty
          ? Align(
              alignment: AlignmentDirectional.centerStart,
              child: VehicleLicensePlateView(licensePlate: plate),
            )
          : null,
      infoItems: [
        SummaryCardInfo(
          icon: Icons.tag_outlined,
          label: 'شماره شاسی',
          value: item.chassisNumber,
        ),
        SummaryCardInfo(
          icon: Icons.settings_outlined,
          label: 'شماره موتور',
          value: item.engineNumber,
        ),
        SummaryCardInfo(
          icon: Icons.calendar_today_outlined,
          label: 'سال ساخت',
          value: item.productYear,
        ),
        SummaryCardInfo(
          icon: Icons.memory_outlined,
          label: 'دستگاه IMEI',
          value: item.imeiSerial,
        ),
        SummaryCardInfo(
          icon: Icons.check_circle_outline_rounded,
          label: 'عیب یاب',
          value: item.isTroubleShooter == true ? 'دارد' : 'ندارد',
        ),
        SummaryCardInfo(
          icon: Icons.inventory_2_outlined,
          label: 'انبارک',
          value: item.isDepotEnabled == true ? 'فعال' : 'غیرفعال',
        ),
      ],
      metaItems: [
        SummaryCardMeta(
          label: 'ثبت‌کننده',
          value: item.insertUserFullName,
          date: JalaliDateHelper.formatStringJalaliDateTime(
            item.insertDateTimeJalali,
          ),
        ),
      ],
      onOperation: () => _showActions(context),
    );
  }

  void _showActions(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      backgroundColor: theme.colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p20,
            right: AppPadding.p20,
            top: AppPadding.p8,
            bottom: AppPadding.p12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppSize.s80,
                height: AppSize.s4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
              ),
              Space.h24,
              BottomSheetActionTile(
                title: 'ابزارها',
                icon: Icons.build_circle_outlined,
                enabled: onTools != null,
                onTap: () => _runAction(context, onTools),
              ),
              BottomSheetActionTile(
                title: 'سرویس‌ها',
                icon: Icons.settings_outlined,
                enabled: onServices != null,
                onTap: () => _runAction(context, onServices),
              ),
              BottomSheetActionTile(
                title: 'تاریخچه',
                icon: Icons.history_rounded,
                enabled: onHistory != null,
                onTap: () => _runAction(context, onHistory),
              ),
              BottomSheetActionTile(
                title: 'حذف',
                icon: Icons.delete_outline_rounded,
                enabled: onDelete != null,
                isDestructive: true,
                onTap: () => _runAction(context, onDelete),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _runAction(BuildContext context, VoidCallback? action) {
    if (action == null) return;
    Navigator.of(context).pop();
    action();
  }

}
