import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/param/get_emdad_vehicle_list_param_entity.dart';

class GetEmdadVehicleListParamModel
    extends GetEmdadVehicleListParamEntity {
  const GetEmdadVehicleListParamModel({
    super.vehicleModelId,
    super.isDepotEnabled,
    super.tashimType,
    super.chassisNumber,
    super.engineNumber,
    super.imeiSerial,
    super.isTroubleShooter,
    super.isActive,
    super.licensePlateFirstPart,
    super.licensePlateLetter,
    super.licensePlateSecondPart,
    super.licensePlateLastPart,
    super.pageSize,
    super.skip,
  });

  Map<String, dynamic> toJson() {
    final filters = <Map<String, dynamic>>[];

    void addFilter({
      required String field,
      String? operator,
      dynamic value,
    }) {
      if (value == null) return;
      if (value is String && value.trim().isEmpty) return;

      final filter = <String, dynamic>{
        'Field': field,
        'Value': value,
      };
      if (operator != null) {
        filter['Operator'] = operator;
      }
      filters.add(filter);
    }

    String? platePart(
      String? value, {
      bool leadingSpace = false,
      bool trailingSpace = false,
    }) {
      final normalized = value?.trim();
      if (normalized == null || normalized.isEmpty) return null;
      return '${leadingSpace ? ' ' : ''}$normalized${trailingSpace ? ' ' : ''}';
    }

    addFilter(
      field: 'vehicleModelId',
      operator: 'eq',
      value: vehicleModelId,
    );
    addFilter(field: 'isDepotEnabled', value: isDepotEnabled);
    addFilter(field: 'tashimType', operator: 'eq', value: tashimType);
    addFilter(
      field: 'chassisNumber',
      operator: 'contains',
      value: chassisNumber,
    );
    addFilter(
      field: 'engineNumber',
      operator: 'contains',
      value: engineNumber,
    );
    addFilter(
      field: 'imeiSerial',
      operator: 'contains',
      value: imeiSerial,
    );
    addFilter(field: 'isTroubleShooter', value: isTroubleShooter);
    addFilter(field: 'isActive', value: isActive);
    addFilter(
      field: 'licensePlate',
      operator: 'startswith',
      value: platePart(licensePlateFirstPart, trailingSpace: true),
    );
    addFilter(
      field: 'licensePlate',
      operator: 'contains',
      value: platePart(
        licensePlateLetter,
        leadingSpace: true,
        trailingSpace: true,
      ),
    );
    addFilter(
      field: 'licensePlate',
      operator: 'contains',
      value: platePart(
        licensePlateSecondPart,
        leadingSpace: true,
        trailingSpace: true,
      ),
    );
    addFilter(
      field: 'licensePlate',
      operator: 'endswith',
      value: platePart(licensePlateLastPart, leadingSpace: true),
    );

    return {
      'Sort': <dynamic>[],
      'Filter': {
        'Logic': 'and',
        'Filters': filters,
      },
      'PageSize': pageSize ?? 10,
      'Skip': skip ?? 0,
    };
  }
}
