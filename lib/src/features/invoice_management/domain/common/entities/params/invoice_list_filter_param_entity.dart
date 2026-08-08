class InvoiceListFilterParamEntity {
  const InvoiceListFilterParamEntity({
    required this.serviceType,
    this.givenCode,
    this.requestTrackCode,
    this.fromDate,
    this.toDate,
    this.showSubscription,
    this.hasObjection,
    this.categoryGivenCode,
    this.agencyCode,
    this.emdadgarName,
    this.pageSize = 20,
    this.skip = 0,
  });

  final int serviceType;
  final int? givenCode;
  final String? requestTrackCode;
  final String? fromDate;
  final String? toDate;
  final bool? showSubscription;
  final bool? hasObjection;
  final String? categoryGivenCode;
  final String? agencyCode;
  final String? emdadgarName;
  final int pageSize;
  final int skip;

  InvoiceListFilterParamEntity copyWith({
    int? serviceType,
    int? givenCode,
    String? requestTrackCode,
    String? fromDate,
    String? toDate,
    bool? showSubscription,
    bool? hasObjection,
    String? categoryGivenCode,
    String? agencyCode,
    String? emdadgarName,
    int? pageSize,
    int? skip,
  }) {
    return InvoiceListFilterParamEntity(
      serviceType: serviceType ?? this.serviceType,
      givenCode: givenCode ?? this.givenCode,
      requestTrackCode: requestTrackCode ?? this.requestTrackCode,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      showSubscription: showSubscription ?? this.showSubscription,
      hasObjection: hasObjection ?? this.hasObjection,
      categoryGivenCode: categoryGivenCode ?? this.categoryGivenCode,
      agencyCode: agencyCode ?? this.agencyCode,
      emdadgarName: emdadgarName ?? this.emdadgarName,
      pageSize: pageSize ?? this.pageSize,
      skip: skip ?? this.skip,
    );
  }
}

