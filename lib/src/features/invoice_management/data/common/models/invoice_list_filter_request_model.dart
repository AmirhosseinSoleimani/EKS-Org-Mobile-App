import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';

class InvoiceListFilterRequestModel extends InvoiceListFilterParamEntity {
  const InvoiceListFilterRequestModel({
    required super.serviceType,
    super.givenCode,
    super.requestTrackCode,
    super.fromDate,
    super.toDate,
    super.showSubscription,
    super.hasObjection,
    super.categoryGivenCode,
    super.agencyCode,
    super.emdadgarName,
    super.pageSize,
    super.skip,
  });

  factory InvoiceListFilterRequestModel.fromEntity(
    InvoiceListFilterParamEntity entity,
  ) {
    return InvoiceListFilterRequestModel(
      serviceType: entity.serviceType,
      givenCode: entity.givenCode,
      requestTrackCode: entity.requestTrackCode,
      fromDate: entity.fromDate,
      toDate: entity.toDate,
      showSubscription: entity.showSubscription,
      hasObjection: entity.hasObjection,
      categoryGivenCode: entity.categoryGivenCode,
      agencyCode: entity.agencyCode,
      emdadgarName: entity.emdadgarName,
      pageSize: entity.pageSize,
      skip: entity.skip,
    );
  }

  Map<String, dynamic> toJson() {
    final filters = <Map<String, dynamic>>[
      _filter('serviceType', 'eq', serviceType),
    ];

    _add(filters, 'requestTrackCode', 'contains', requestTrackCode);
    _add(filters, 'fromDate', 'contains', fromDate);
    _add(filters, 'toDate', 'contains', toDate);
    _add(filters, 'showSubscription', 'eq', showSubscription);
    _add(filters, 'hasObjection', 'eq', hasObjection);
    _add(filters, 'givencode', 'eq', givenCode);
    _add(filters, 'categorygivencode', 'contains', categoryGivenCode);
    _add(filters, 'agencyCode', 'contains', agencyCode);
    _add(filters, 'emdadgarName', 'contains', emdadgarName);

    return <String, dynamic>{
      'serviceType': serviceType,
      'givencode': givenCode,
      'Filter': <String, dynamic>{
        'Logic': 'and',
        'Filters': filters,
      },
      'PageSize': pageSize,
      'Skip': skip,
      'Sort': const <Map<String, dynamic>>[],
    };
  }

  static void _add(
    List<Map<String, dynamic>> target,
    String field,
    String operatorValue,
    Object? value,
  ) {
    if (value == null) return;
    if (value is String && value.trim().isEmpty) return;
    target.add(_filter(field, operatorValue, value));
  }

  static Map<String, dynamic> _filter(
    String field,
    String operatorValue,
    Object value,
  ) {
    return <String, dynamic>{
      'Field': field,
      'Operator': operatorValue,
      'Value': value,
    };
  }
}
