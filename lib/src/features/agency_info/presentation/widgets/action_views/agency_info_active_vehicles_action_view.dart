import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_agency_header.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/presentation/widgets/agency_info_action_content_widgets.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/vehicle_license_plate_view.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/list_item_text.dart';
import 'package:flutter/material.dart';

class AgencyInfoActiveVehiclesActionView extends StatelessWidget {
  const AgencyInfoActiveVehiclesActionView({
    super.key,
    required this.item,
    required this.vehicles,
    this.showSectionHeader = true,
  });

  final AgencyInfoEntity item;
  final AgencyVehiclePageEntity vehicles;
  final bool showSectionHeader;

  @override
  Widget build(BuildContext context) {
    final records = vehicles.records ?? const <AgencyVehicleEntity>[];
    final count = (vehicles.count ?? 0) > 0 ? vehicles.count! : records.length;

    return Column(
      children: [
        AgencyInfoActionAgencyHeader(item: item),
        Space.h24,
        if (showSectionHeader) ...[
          AgencyInfoActionSectionHeader(
            title: 'خودروهای فعلی',
            count: count,
          ),
          Space.h16,
        ],
        Expanded(
          child: records.isEmpty
              ? const EmptyListWidget()
              : ListView.separated(
            padding: const EdgeInsets.only(bottom: AppPadding.p24),
            itemCount: records.length,
            separatorBuilder: (_, __) => Space.h12,
            itemBuilder: (context, index) {
              return _AgencyVehicleItem(vehicle: records[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _AgencyVehicleItem extends StatelessWidget {
  const _AgencyVehicleItem({required this.vehicle});

  final AgencyVehicleEntity vehicle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final licensePlate = vehicle.licensePlate?.trim();
    final isActive = _isActive(vehicle) ?? false;
    return AgencyInfoActionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListItemTitleText(
                  text: _vehicleTitle(vehicle),
                  maxLines: 2,
                ),
              ),
              Space.w8,
              StatusLabel(text: isActive? 'فعال' : 'غیرفعال', color: isActive ? colorScheme.onError : colorScheme.error),
            ],
          ),
          Space.h12,
          if (licensePlate?.isNotEmpty == true) ...[
            Align(
              alignment: Alignment.centerRight,
              child: VehicleLicensePlateView(
                licensePlate: licensePlate!,
              ),
            ),
            Space.h8,
          ],
          AgencyInfoActionIconInfoRow(
            icon: Icons.tag_rounded,
            label: 'شماره شاسی',
            value: vehicle.chassisNo,
          ),
          AgencyInfoActionIconInfoRow(
            icon: Icons.settings_outlined,
            label: 'شماره موتور',
            value: vehicle.engineNumber,
          ),
          AgencyInfoActionIconInfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'سال ساخت',
            value: vehicle.productYear,
          ),
          AgencyInfoActionIconInfoRow(
            icon: Icons.memory_outlined,
            label: 'دستگاه IMEI',
            value: _firstNonEmpty([
              vehicle.imei,
              vehicle.imeiSerial,
              vehicle.imeiId?.toString(),
            ]),
          ),
          AgencyInfoActionIconInfoRow(
            icon: Icons.check_circle_outline_rounded,
            label: 'عیب‌یابی',
            value: _troubleShooterTitle(vehicle.isTroubleShooter),
          ),
        ],
      ),
    );
  }

  static String _vehicleTitle(AgencyVehicleEntity vehicle) {
    final model = _firstNonEmpty([
      vehicle.vehicleModelTitle,
      vehicle.vehicleModelName,
    ]);
    final fleetType = vehicle.navganTypeTitle?.trim();

    if (model == null && (fleetType == null || fleetType.isEmpty)) {
      return '---';
    }
    if (model == null) return fleetType!;
    if (fleetType == null || fleetType.isEmpty) return model;

    return '$model ($fleetType)';
  }

  static bool? _isActive(AgencyVehicleEntity vehicle) {
    if (vehicle.isActive != null) return vehicle.isActive;
    if (vehicle.status != null) return vehicle.status == 1;

    final statusTitle = vehicle.statusTitle?.trim().toLowerCase();
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
      if (value
          ?.trim()
          .isNotEmpty == true) return value!.trim();
    }
    return null;
  }
}
