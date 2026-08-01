import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_filter_param_entity.dart';

class VehicleModelFilterRequestModel {
  const VehicleModelFilterRequestModel({
    this.skip = 0,
    this.pageSize = 10,
    this.filters = const [],
  });

  final int skip;
  final int pageSize;
  final List<VehicleModelFilterModel> filters;

  factory VehicleModelFilterRequestModel.fromParam(
    VehicleModelFilterParamEntity param,
  ) {
    final filters = <VehicleModelFilterModel>[];
    if (param.code?.trim().isNotEmpty == true) {
      filters.add(VehicleModelFilterModel(
        field: 'code',
        operator: 'contains',
        value: param.code!.trim(),
      ));
    }
    if (param.name?.trim().isNotEmpty == true) {
      filters.add(VehicleModelFilterModel(
        field: 'name',
        operator: 'contains',
        value: param.name!.trim(),
      ));
    }
    if (param.isActive != null) {
      filters.add(VehicleModelFilterModel(
        field: 'isActive',
        value: param.isActive!,
      ));
    }
    if (param.navganTypeTitle?.trim().isNotEmpty == true) {
      filters.add(VehicleModelFilterModel(
        field: 'navganTypeTitle',
        operator: 'contains',
        value: param.navganTypeTitle!.trim(),
      ));
    }
    if (param.hasDepot != null) {
      filters.add(VehicleModelFilterModel(
        field: 'hasDepot',
        value: param.hasDepot!,
      ));
    }

    return VehicleModelFilterRequestModel(
      skip: param.skip,
      pageSize: param.pageSize,
      filters: filters,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Sort': const [],
      'Filter': {
        'Logic': 'and',
        'Filters': filters.map((item) => item.toJson()).toList(),
      },
      'PageSize': pageSize,
      if (skip > 0 || filters.isNotEmpty) 'Skip': skip,
    };
  }
}

class VehicleModelFilterModel {
  const VehicleModelFilterModel({
    required this.field,
    required this.value,
    this.operator,
  });

  final String field;
  final dynamic value;
  final String? operator;

  Map<String, dynamic> toJson() {
    return {
      'Field': field,
      if (operator != null) 'Operator': operator,
      'Value': value,
    };
  }
}
