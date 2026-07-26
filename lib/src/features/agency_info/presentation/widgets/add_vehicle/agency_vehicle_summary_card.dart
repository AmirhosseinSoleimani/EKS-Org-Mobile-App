import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_status_badge.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/vehicle_license_plate_view.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class AgencyVehicleSummaryCard extends StatelessWidget {
  const AgencyVehicleSummaryCard({
    super.key,
    required this.vehicle,
    this.onAdd,
    this.compact = false,
  });

  final VehicleInfoSearchEntity vehicle;
  final VoidCallback? onAdd;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final licensePlate = vehicle.licensePlate?.trim();

    return AgencyInfoActionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BodyMediumText(
                  text: _vehicleTitle(vehicle),
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  fontSize: AppSize.s16,
                ),
              ),
              if (!compact) ...[
                Space.w8,
                AgencyInfoStatusBadge(isActive: _isActive(vehicle)),
              ],
            ],
          ),
          Space.h12,
          if (licensePlate?.isNotEmpty == true) ...[
            Align(
              alignment: Alignment.centerRight,
              child: VehicleLicensePlateView(licensePlate: licensePlate!),
            ),
            Space.h12,
          ],
          _InfoRow(
            icon: Icons.tag_rounded,
            label: 'شماره شاسی',
            value: vehicle.chassisNumber,
          ),
          _InfoRow(
            icon: Icons.settings_outlined,
            label: 'شماره موتور',
            value: vehicle.engineNumber,
          ),
          if (!compact) ...[
            _InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'سال ساخت',
              value: vehicle.productYear,
            ),
          ],
          _InfoRow(
            icon: Icons.memory_outlined,
            label: 'دستگاه IMEI',
            value: _firstNonEmpty([
              vehicle.imeiSerial,
              vehicle.imeiId?.toString(),
            ]),
          ),
          if (!compact)
            _InfoRow(
              icon: Icons.check_circle_outline_rounded,
              label: 'عیب‌یابی',
              value: _troubleShooterTitle(vehicle.isTroubleShooter),
            ),
          if (onAdd != null) ...[
            Space.h12,
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: AppSize.s40,
                height: AppSize.s40,
                child: Material(
                  color: colorScheme.primary,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onAdd,
                    child: Icon(
                      Icons.add_rounded,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static String _vehicleTitle(VehicleInfoSearchEntity vehicle) {
    final model = _firstNonEmpty([
      vehicle.vehicleModelTitle,
      vehicle.vehicleModelName,
    ]);
    final type = vehicle.tashimTypeTitle?.trim();

    if (model == null && (type == null || type.isEmpty)) return '---';
    if (model == null) return type!;
    if (type == null || type.isEmpty) return model;
    return '$model ($type)';
  }

  static bool? _isActive(VehicleInfoSearchEntity vehicle) {
    if (vehicle.isActive != null) return vehicle.isActive;
    if (vehicle.vehicleStatus != null) return vehicle.vehicleStatus == 1;

    final statusTitle = vehicle.vehicleStatusTitle?.trim().toLowerCase();
    if (statusTitle == null || statusTitle.isEmpty) return null;
    if (statusTitle.contains('غیر فعال') || statusTitle.contains('غیرفعال')) {
      return false;
    }
    if (statusTitle.contains('فعال')) return true;
    return null;
  }

  static String? _troubleShooterTitle(bool? isTroubleShooter) {
    if (isTroubleShooter == null) return null;
    return isTroubleShooter ? 'دارد' : 'ندارد';
  }

  static String? _firstNonEmpty(Iterable<String?> values) {
    for (final value in values) {
      if (value?.trim().isNotEmpty == true) return value!.trim();
    }
    return null;
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: AppSize.s18,
            color: colorScheme.onTertiaryFixed,
          ),
          Space.w8,
          Expanded(
            child: BodyMediumText(
              text: '$label: ${AgencyInfoActionFormatter.valueOrDash(value)}',
              color: colorScheme.onSurfaceVariant,
              lineHeight: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
