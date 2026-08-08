import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_filter_param_model.dart';

class InvoiceAgencyObjectionFilterParamEntity {
  const InvoiceAgencyObjectionFilterParamEntity({
    this.filters,
    this.pageSize,
    this.skip,
  });

  final List<InvoiceAgencyObjectionFilterItemParamEntity>? filters;
  final int? pageSize;
  final int? skip;

  InvoiceAgencyObjectionFilterParamModel toModel() {
    return InvoiceAgencyObjectionFilterParamModel(
      filters: filters,
      pageSize: pageSize,
      skip: skip,
    );
  }
}

class InvoiceAgencyObjectionFilterItemParamEntity {
  const InvoiceAgencyObjectionFilterItemParamEntity({
    this.field,
    this.operatorValue,
    this.value,
  });

  final String? field;
  final String? operatorValue;
  final Object? value;

  InvoiceAgencyObjectionFilterItemParamModel toModel() {
    return InvoiceAgencyObjectionFilterItemParamModel(
      field: field,
      operatorValue: operatorValue,
      value: value,
    );
  }
}
