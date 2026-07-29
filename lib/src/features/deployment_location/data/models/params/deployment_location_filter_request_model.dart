import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/params/deployment_location_filter_param_entity.dart';

class DeploymentLocationFilterRequestModel {
  const DeploymentLocationFilterRequestModel({
    this.skip = 0,
    this.pageSize = 10,
    this.filters = const [],
  });

  final int skip;
  final int pageSize;
  final List<DeploymentLocationFilterModel> filters;

  factory DeploymentLocationFilterRequestModel.fromParam(
    DeploymentLocationFilterParamEntity param,
  ) {
    final filters = <DeploymentLocationFilterModel>[];
    _addTextFilter(filters, 'title', param.title);
    _addTextFilter(filters, 'provinceTitle', param.provinceTitle);
    _addTextFilter(filters, 'cityTitle', param.cityTitle);
    _addTextFilter(filters, 'address', param.address);

    if (param.isActive != null) {
      filters.add(
        DeploymentLocationFilterModel(
          field: 'isActive',
          value: param.isActive!,
        ),
      );
    }

    return DeploymentLocationFilterRequestModel(
      skip: param.skip,
      pageSize: param.pageSize,
      filters: filters,
    );
  }

  static void _addTextFilter(
    List<DeploymentLocationFilterModel> filters,
    String field,
    String? value,
  ) {
    final normalized = value?.trim();
    if (normalized?.isNotEmpty != true) return;
    filters.add(
      DeploymentLocationFilterModel(
        field: field,
        operator: 'contains',
        value: normalized!,
      ),
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
      'Skip': skip,
    };
  }
}

class DeploymentLocationFilterModel {
  const DeploymentLocationFilterModel({
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
