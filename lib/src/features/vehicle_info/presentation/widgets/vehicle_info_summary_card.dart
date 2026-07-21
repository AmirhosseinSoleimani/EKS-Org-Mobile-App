import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p16,
          AppPadding.p16,
          AppPadding.p14,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(AppSize.s8),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.06),
              blurRadius: AppSize.s16,
              offset: const Offset(0, 8),
            ),
          ],
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
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                VehicleInfoStatusBadge(title: item.vehicleStatusTitle, isActive: item.isActive),
              ],
            ),
            Space.h16,
            if (item.licensePlate?.trim().isNotEmpty == true) ...[
              Align(
                alignment: Alignment.centerRight,
                child: VehicleLicensePlateView(licensePlate: item.licensePlate!),
              ),
              Space.h16,
            ],
            _DetailLine(
              icon: Icons.tag_outlined,
              label: 'شماره شاسی',
              value: item.chassisNumber,
            ),
            _DetailLine(
              icon: Icons.settings_outlined,
              label: 'شماره موتور',
              value: item.engineNumber,
            ),
            _DetailLine(
              icon: Icons.calendar_today_outlined,
              label: 'سال ساخت',
              value: item.productYear,
            ),
            _DetailLine(
              icon: Icons.memory_outlined,
              label: 'دستگاه IMEI',
              value: item.imeiSerial,
            ),
            _DetailLine(
              icon: Icons.check_circle_outline_rounded,
              label: 'عیب یاب',
              value: item.isTroubleShooter == true ? 'دارد' : 'ندارد',
            ),
            _DetailLine(
              icon: Icons.inventory_2_outlined,
              label: 'انبارک',
              value: item.isDepotEnabled == true ? 'فعال' : 'غیرفعال',
            ),
            Space.h16,
            Divider(height: AppSize.s1, color: theme.dividerColor),
            Space.h16,
            Row(
              children: [
                Expanded(
                  child: Text(
                    'ثبت کننده: ${_dash(item.insertUserFullName)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(
                  _dash(item.insertDateTimeJalali),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            Space.h24,
            _OperationButton(onTap: () => _showActions(context)),
          ],
        ),
      ),
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
              _ActionTile(
                title: 'ابزار ها',
                icon: Icons.build_circle_outlined,
                onTap: onTools,
              ),
              _ActionTile(
                title: 'سرویس ها',
                icon: Icons.settings_outlined,
                onTap: onServices,
              ),
              _ActionTile(
                title: 'تاریخچه',
                icon: Icons.history_rounded,
                onTap: onHistory,
              ),
              _ActionTile(
                title: 'حذف',
                icon: Icons.delete_outline_rounded,
                onTap: onDelete,
                color: theme.colorScheme.error,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _dash(String? value) => value?.trim().isNotEmpty == true ? value!.trim() : '---';
}

class _DetailLine extends StatelessWidget {
  const _DetailLine({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayValue = value?.trim().isNotEmpty == true ? value!.trim() : '---';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        children: [
          Icon(icon, size: AppSize.s20, color: Color(0xFF555555)),
          Space.w8,
          Expanded(
            child: Text(
              '$label: $displayValue',
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Color(0xFF555555),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OperationButton extends StatelessWidget {
  const _OperationButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: SizedBox(
          height: AppSize.s48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings_outlined, size: AppSize.s20, color: theme.colorScheme.onSurfaceVariant),
              Space.w8,
              Text(
                'عملیات',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Space.w8,
              Icon(Icons.keyboard_arrow_down_rounded, size: AppSize.s22, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.icon,
    this.onTap,
    this.color,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap == null
          ? null
          : () {
              Navigator.of(context).pop();
              onTap!();
            },
      child: Container(
        height: AppSize.s48,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: theme.dividerColor.withOpacity(0.45)),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: color ?? theme.colorScheme.onTertiaryFixed),
            Space.w12,
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color ?? theme.colorScheme.onTertiaryFixed,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleLicensePlateView extends StatelessWidget {
  const VehicleLicensePlateView({
    super.key,
    required this.licensePlate,
  });

  final String licensePlate;

  @override
  Widget build(BuildContext context) {
    final parts = licensePlate.trim().split(RegExp(r'\s+'));
    final normalized = parts.length >= 4 ? parts.take(4).toList() : <String>['--', '-', '---', '--'];

    return Container(
      height: AppSize.s42,
      constraints: const BoxConstraints(maxWidth: 196),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.black87),
        borderRadius: BorderRadius.circular(AppSize.s6),
      ),
      child: Row(
        children: [
          _PlateCell(normalized[3], flex: 2),
          VerticalDivider(
            thickness: AppSize.s1,
            color: Theme.of(context).colorScheme.shadow,
          ),

          _PlateCell(normalized[0], flex: 2),
          _PlateCell(normalized[1], flex: 2),
          _PlateCell(normalized[2], flex: 3),

          Container(
            width: AppSize.s28,
            height: double.infinity,
            color: const Color(0xFF073DA1),
            alignment: Alignment.center,
            child: const Text(
              'I.R.\nIRAN',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlateCell extends StatelessWidget {
  const _PlateCell(this.text, {required this.flex});

  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: AppSize.s14
              ),
        ),
      ),
    );
  }
}
