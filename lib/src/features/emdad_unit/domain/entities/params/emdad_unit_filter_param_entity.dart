import 'package:eks_sana_plus_org/src/features/emdad_unit/data/models/emdad_unit_filter_request_model.dart';

class EmdadUnitFilterParamEntity {
  const EmdadUnitFilterParamEntity({
    this.name,
    this.agencyInfoName,
    this.vehicleInfoTitle,
    this.personInfoFullName,
    this.seatType,
    this.locationTitle,
    this.grade,
    this.isActive,
    this.skip = 0,
    this.pageSize = 10,
  });

  final String? name;
  final String? agencyInfoName;
  final String? vehicleInfoTitle;
  final String? personInfoFullName;
  final int? seatType;
  final String? locationTitle;
  final int? grade;
  final bool? isActive;
  final int skip;
  final int pageSize;

  EmdadUnitFilterRequestModel toModel() {
    final filters = <EmdadUnitFilterModel>[];

    void addText(String field, String? value) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) {
        filters.add(EmdadUnitFilterModel(field: field, value: trimmed));
      }
    }

    addText('name', name);
    addText('agencyInfoName', agencyInfoName);
    addText('vehicleInfoTitle', vehicleInfoTitle);
    addText('personInfoFullName', personInfoFullName);
    addText('locationTitle', locationTitle);

    if (seatType != null && seatType! > -1) {
      filters.add(EmdadUnitFilterModel(
        field: 'seatType',
        value: seatType.toString(),
        operator: 'eq',
      ));
    }

    if (grade != null && grade! > -1) {
      filters.add(EmdadUnitFilterModel(
        field: 'grade',
        value: grade.toString(),
        operator: 'eq',
      ));
    }

    if (isActive != null) {
      filters.add(EmdadUnitFilterModel(
        field: 'isActive',
        value: isActive.toString(),
        operator: 'eq',
      ));
    }

    return EmdadUnitFilterRequestModel(
      skip: skip,
      pageSize: pageSize,
      filters: filters,
    );
  }

  EmdadUnitFilterParamEntity copyWith({
    String? name,
    String? agencyInfoName,
    String? vehicleInfoTitle,
    String? personInfoFullName,
    int? seatType,
    String? locationTitle,
    int? grade,
    bool? isActive,
    bool clearIsActive = false,
    int? skip,
    int? pageSize,
  }) {
    return EmdadUnitFilterParamEntity(
      name: name ?? this.name,
      agencyInfoName: agencyInfoName ?? this.agencyInfoName,
      vehicleInfoTitle: vehicleInfoTitle ?? this.vehicleInfoTitle,
      personInfoFullName: personInfoFullName ?? this.personInfoFullName,
      seatType: seatType ?? this.seatType,
      locationTitle: locationTitle ?? this.locationTitle,
      grade: grade ?? this.grade,
      isActive: clearIsActive ? null : isActive ?? this.isActive,
      skip: skip ?? this.skip,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
