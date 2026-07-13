import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_filter_request_model.dart';

class AgencyInfoFilterParamEntity {
  const AgencyInfoFilterParamEntity({
    this.name,
    this.code,
    this.managerFullName,
    this.provinceTitle,
    this.cityTitle,
    this.mobileNumber,
    this.isActive,
    this.skip = 0,
    this.pageSize = 10,
  });

  final String? name;
  final String? code;
  final String? managerFullName;
  final String? provinceTitle;
  final String? cityTitle;
  final String? mobileNumber;
  final bool? isActive;
  final int skip;
  final int pageSize;

  AgencyInfoFilterRequestModel toModel() {
    final filters = <AgencyInfoFilterModel>[];

    void addText(String field, String? value) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) {
        filters.add(AgencyInfoFilterModel(field: field, value: trimmed));
      }
    }

    addText('name', name);
    addText('code', code);
    addText('managerFullName', managerFullName);
    addText('provinceTitle', provinceTitle);
    addText('cityTitle', cityTitle);
    addText('mobileNumber', mobileNumber);

    if (isActive != null) {
      filters.add(AgencyInfoFilterModel(
        field: 'isActive',
        operator: 'eq',
        value: isActive.toString(),
      ));
    }

    return AgencyInfoFilterRequestModel(
      skip: skip,
      pageSize: pageSize,
      filters: filters,
    );
  }

  AgencyInfoFilterParamEntity copyWith({
    String? name,
    String? code,
    String? managerFullName,
    String? provinceTitle,
    String? cityTitle,
    String? mobileNumber,
    bool? isActive,
    bool clearIsActive = false,
    int? skip,
    int? pageSize,
  }) {
    return AgencyInfoFilterParamEntity(
      name: name ?? this.name,
      code: code ?? this.code,
      managerFullName: managerFullName ?? this.managerFullName,
      provinceTitle: provinceTitle ?? this.provinceTitle,
      cityTitle: cityTitle ?? this.cityTitle,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      isActive: clearIsActive ? null : isActive ?? this.isActive,
      skip: skip ?? this.skip,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
