import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_filter_request_model.dart';

class AgencyInfoFilterParamEntity {
  const AgencyInfoFilterParamEntity({
    this.code,
    this.name,
    this.type,
    this.managerFirstName,
    this.managerLastName,
    this.nationalNo,
    this.economicCode,
    this.mobile,
    this.provinceName,
    this.cityName,
    this.detailedCode,
    this.agencyNationalId,
    this.trackingNumber,
    this.taxFileCompleted,
    this.isActive,
    this.skip = 0,
    this.pageSize = 10,
  });

  final String? code;
  final String? name;
  final int? type;
  final String? managerFirstName;
  final String? managerLastName;
  final String? nationalNo;
  final String? economicCode;
  final String? mobile;
  final String? provinceName;
  final String? cityName;
  final String? detailedCode;
  final String? agencyNationalId;
  final String? trackingNumber;
  final bool? taxFileCompleted;
  final bool? isActive;
  final int skip;
  final int pageSize;

  AgencyInfoFilterRequestModel toModel() {
    final filters = <AgencyInfoFilterModel>[];

    void addText(String field, String? value) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) {
        filters.add(
          AgencyInfoFilterModel(
            field: field,
            operator: 'contains',
            value: trimmed,
          ),
        );
      }
    }

    void addEqual(String field, Object? value) {
      if (value != null) {
        filters.add(
          AgencyInfoFilterModel(
            field: field,
            operator: 'eq',
            value: value,
          ),
        );
      }
    }

    addText('name', name);
    addText('code', code);
    addEqual('type', type);
    addText('detailedCode', detailedCode);
    addText('agencyNationalId', agencyNationalId);
    addText('trackingNumber', trackingNumber);
    addEqual('taxFileCompleted', taxFileCompleted);
    addEqual('isActive', isActive);
    addText('managerFirstName', managerFirstName);
    addText('managerLastName', managerLastName);
    addText('nationalNo', nationalNo);
    addText('economicCode', economicCode);
    addText('mobile', mobile);
    addText('provinceName', provinceName);
    addText('cityName', cityName);

    return AgencyInfoFilterRequestModel(
      skip: skip,
      pageSize: pageSize,
      filters: filters,
    );
  }

  AgencyInfoFilterParamEntity copyWith({
    String? code,
    String? name,
    int? type,
    bool clearType = false,
    String? managerFirstName,
    String? managerLastName,
    String? nationalNo,
    String? economicCode,
    String? mobile,
    String? provinceName,
    String? cityName,
    String? detailedCode,
    String? agencyNationalId,
    String? trackingNumber,
    bool? taxFileCompleted,
    bool clearTaxFileCompleted = false,
    bool? isActive,
    bool clearIsActive = false,
    int? skip,
    int? pageSize,
  }) {
    return AgencyInfoFilterParamEntity(
      code: code ?? this.code,
      name: name ?? this.name,
      type: clearType ? null : type ?? this.type,
      managerFirstName: managerFirstName ?? this.managerFirstName,
      managerLastName: managerLastName ?? this.managerLastName,
      nationalNo: nationalNo ?? this.nationalNo,
      economicCode: economicCode ?? this.economicCode,
      mobile: mobile ?? this.mobile,
      provinceName: provinceName ?? this.provinceName,
      cityName: cityName ?? this.cityName,
      detailedCode: detailedCode ?? this.detailedCode,
      agencyNationalId: agencyNationalId ?? this.agencyNationalId,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      taxFileCompleted: clearTaxFileCompleted
          ? null
          : taxFileCompleted ?? this.taxFileCompleted,
      isActive: clearIsActive ? null : isActive ?? this.isActive,
      skip: skip ?? this.skip,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
