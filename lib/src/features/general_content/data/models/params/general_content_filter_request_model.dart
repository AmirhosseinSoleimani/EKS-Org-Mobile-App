import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/params/general_content_filter_param_entity.dart';

class GeneralContentFilterRequestModel {
  const GeneralContentFilterRequestModel({
    this.skip = 0,
    this.pageSize = 10,
    this.filters = const [],
  });

  final int skip;
  final int pageSize;
  final List<GeneralContentFilterModel> filters;

  factory GeneralContentFilterRequestModel.fromParam(
    GeneralContentFilterParamEntity param,
  ) {
    final filters = <GeneralContentFilterModel>[];
    final title = param.title?.trim();
    if (title != null && title.isNotEmpty) {
      filters.add(GeneralContentFilterModel(field: 'title', value: title));
    }
    final contentType = param.contentType;
    if (contentType != null) {
      filters.add(GeneralContentFilterModel(
        field: 'contentType',
        operator: 'eq',
        value: contentType.toString(),
      ));
    }

    return GeneralContentFilterRequestModel(
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
      'Skip': skip,
      'PageSize': pageSize,
    };
  }
}

class GeneralContentFilterModel {
  const GeneralContentFilterModel({
    required this.field,
    required this.value,
    this.operator = 'contains',
  });

  final String field;
  final String value;
  final String operator;

  Map<String, dynamic> toJson() {
    return {
      'Field': field,
      'Operator': operator,
      'Value': value,
    };
  }
}
