import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';

class InvoiceListFilterRequestModel extends InvoiceListFilterParamEntity {
  const InvoiceListFilterRequestModel({
    super.serviceType,
    super.givenCode,
    super.requestTrackCode,
    super.fromDate,
    super.toDate,
    super.invoiceStatus,
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
  ) => entity.toModel();

  Map<String, dynamic> toJson() {
    final filters = <Map<String, dynamic>>[];

    _add(filters, 'serviceType', 'eq', serviceType?.value);
    _add(filters, 'requestTrackCode', 'contains', requestTrackCode);
    _add(filters, 'fromDate', 'contains', fromDate);
    _add(filters, 'toDate', 'contains', toDate);
    _add(filters, 'invoiceStatus', 'eq', invoiceStatus);
    _add(filters, 'showSubscription', 'eq', showSubscription);
    _add(filters, 'hasObjection', 'eq', hasObjection);
    _add(filters, 'givencode', 'eq', givenCode);
    _add(filters, 'categorygivencode', 'contains', categoryGivenCode);
    _add(filters, 'agencyCode', 'contains', agencyCode);
    _add(filters, 'emdadgarName', 'contains', emdadgarName);

    return <String, dynamic>{
      'serviceType': serviceType?.value,
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
    target.add(<String, dynamic>{
      'Field': field,
      'Operator': operatorValue,
      'Value': value,
    });
  }
}
