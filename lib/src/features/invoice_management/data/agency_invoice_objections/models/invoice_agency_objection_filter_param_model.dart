import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/params/invoice_agency_objection_filter_param_entity.dart';

class InvoiceAgencyObjectionFilterParamModel
    extends InvoiceAgencyObjectionFilterParamEntity {
  const InvoiceAgencyObjectionFilterParamModel({
    super.filters,
    super.pageSize,
    super.skip,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Filter': <String, dynamic>{
        'Logic': 'and',
        'Filters': filters?.map((item) => item.toModel().toJson()).toList() ??
            const <Map<String, dynamic>>[],
      },
      'PageSize': pageSize,
      'Skip': skip,
      'Sort': const <Map<String, dynamic>>[],
    };
  }
}

class InvoiceAgencyObjectionFilterItemParamModel
    extends InvoiceAgencyObjectionFilterItemParamEntity {
  const InvoiceAgencyObjectionFilterItemParamModel({
    super.field,
    super.operatorValue,
    super.value,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Field': field,
      'Operator': operatorValue,
      'Value': value,
    };
  }
}
