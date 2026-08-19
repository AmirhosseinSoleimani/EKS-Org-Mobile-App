import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_list_filter_request_model.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';

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

  factory InvoiceListFilterParamEntity.withDefaultDateRange({
    DateTime? now,
    ServiceType serviceType = ServiceType.reliefService,
    int? pageSize,
    int? skip,
  }) {
    final today = now ?? DateTime.now();
    final fromDate = today.subtract(const Duration(days: 7));

    return InvoiceListFilterParamEntity(
      serviceType: serviceType,
      fromDate: JalaliDateHelper.formatServerDateOnly(fromDate),
      toDate: JalaliDateHelper.formatServerDateOnly(today),
      pageSize: pageSize,
      skip: skip,
    );
  }
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
