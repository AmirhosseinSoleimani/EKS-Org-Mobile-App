import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';

class InvoiceListFilterParamEntity {
  const InvoiceListFilterParamEntity({
    this.serviceType,
    this.givenCode,
    this.requestTrackCode,
    this.fromDate,
    this.toDate,
    this.invoiceStatus,
    this.showSubscription,
    this.hasObjection,
    this.categoryGivenCode,
    this.agencyCode,
    this.emdadgarName,
    this.pageSize,
    this.skip,
  });

  final ServiceType? serviceType;
  final int? givenCode;
  final String? requestTrackCode;
  final String? fromDate;
  final String? toDate;
  final int? invoiceStatus;
  final bool? showSubscription;
  final bool? hasObjection;
  final String? categoryGivenCode;
  final String? agencyCode;
  final String? emdadgarName;
  final int? pageSize;
  final int? skip;

  InvoiceListFilterRequestModel toModel() {
    return InvoiceListFilterRequestModel(
      serviceType: serviceType,
      givenCode: givenCode,
      requestTrackCode: requestTrackCode,
      fromDate: fromDate,
      toDate: toDate,
      invoiceStatus: invoiceStatus,
      showSubscription: showSubscription,
      hasObjection: hasObjection,
      categoryGivenCode: categoryGivenCode,
      agencyCode: agencyCode,
      emdadgarName: emdadgarName,
      pageSize: pageSize,
      skip: skip,
    );
  }
}
