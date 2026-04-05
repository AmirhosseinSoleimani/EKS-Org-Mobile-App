import 'package:eks_sana_plus_org/src/features/requests/data/models/request_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/enums/invoice_type.dart';

class RequestEntity {
  final int? id;
  final String? requestNo;
  final String? requestDate;
  final int? status;
  final String? statusTitle;
  final int? type;
  final String? chassisNo;
  final String? licensePlate;
  final String? distanceTraveledKm;
  final String? lastName;
  final String? khedmatResanFullName;
  final String? khedmatResanCode;
  final String? typeTitle;
  final int? defectId;
  final String? defectTitle;
  final String? defectDescription;
  final String? nationalCode;
  final String? firstName;
  final String? submitDate;
  final String? submitTime;
  final String? serviceDate;
  final String? serviceTime;
  final bool? hasSubscription;
  final bool? isGuaranty;
  final String? carName;
  final int? carModelId;
  final LocationEntity? location;
  final List<RequestHistoryActionsEntity>? actions;
  final int? callLogId;
  final int? channelType;
  final int? cityId;
  final String? vin;
  final int? gender;
  final int? kilometer;
  final int? evaluationKilometer;
  final int? customerDisability;
  final int? trackCode;
  final int? carColor;
  final String? customerDisabilityTitle;
  final String? customerMobileNumber;
  final String? carEngineNumber;
  final String? carColorTitle;
  final bool? foreigner;
  final bool? vip;
  final bool? hasEmdadgarInvoice;

  const RequestEntity({
    this.id,
    this.requestNo,
    this.requestDate,
    this.status,
    this.statusTitle,
    this.type,
    this.chassisNo,
    this.licensePlate,
    this.distanceTraveledKm,
    this.lastName,
    this.khedmatResanFullName,
    this.khedmatResanCode,
    this.typeTitle,
    this.actions,
    this.defectId,
    this.defectTitle,
    this.defectDescription,
    this.nationalCode,
    this.serviceTime,
    this.serviceDate,
    this.submitTime,
    this.submitDate,
    this.firstName,
    this.hasSubscription,
    this.isGuaranty,
    this.carModelId,
    this.carName,
    this.location,
    this.callLogId,
    this.channelType,
    this.cityId,
    this.vin,
    this.gender,
    this.kilometer,
    this.evaluationKilometer,
    this.customerDisability,
    this.trackCode,
    this.carColor,
    this.customerDisabilityTitle,
    this.customerMobileNumber,
    this.carEngineNumber,
    this.carColorTitle,
    this.foreigner,
    this.vip,
    this.hasEmdadgarInvoice,
  });

  RequestEntity copyWith({
    int? id,
    String? requestNo,
    String? requestDate,
    int? status,
    String? statusTitle,
    int? type,
    String? chassisNo,
    String? licensePlate,
    String? distanceTraveledKm,
    String? lastName,
    String? khedmatResanFullName,
    String? khedmatResanCode,
    String? typeTitle,
    List<RequestHistoryActionsEntity>? actions,
    int? defectId,
    String? defectTitle,
    String? defectDescription,
    String? nationalCode,
    String? firstName,
    String? submitDate,
    String? submitTime,
    String? serviceDate,
    String? serviceTime,
    bool? hasSubscription,
    bool? isGuaranty,
    String? carName,
    int? carModelId,
    LocationEntity? location,
    int? callLogId,
    int? channelType,
    int? cityId,
    String? vin,
    int? gender,
    int? kilometer,
    int? evaluationKilometer,
    int? customerDisability,
    int? trackCode,
    int? carColor,
    String? customerDisabilityTitle,
    String? customerMobileNumber,
    String? carEngineNumber,
    String? carColorTitle,
    bool? foreigner,
    bool? vip,
    bool? hasEmdadgarInvoice,
  }) {
    return RequestEntity(
      id: id ?? this.id,
      requestNo: requestNo ?? this.requestNo,
      requestDate: requestDate ?? this.requestDate,
      status: status ?? this.status,
      statusTitle: statusTitle ?? this.statusTitle,
      type: type ?? this.type,
      chassisNo: chassisNo ?? this.chassisNo,
      licensePlate: licensePlate ?? this.licensePlate,
      distanceTraveledKm: distanceTraveledKm ?? this.distanceTraveledKm,
      lastName: lastName ?? this.lastName,
      khedmatResanFullName: khedmatResanFullName ?? this.khedmatResanFullName,
      khedmatResanCode: khedmatResanCode ?? this.khedmatResanCode,
      typeTitle: typeTitle ?? this.typeTitle,
      actions: actions ?? this.actions,
      defectId: defectId ?? this.defectId,
      defectTitle: defectTitle ?? this.defectTitle,
      defectDescription: defectDescription ?? this.defectDescription,
      nationalCode: nationalCode ?? this.nationalCode,
      firstName: firstName ?? this.firstName,
      submitDate: submitDate ?? this.submitDate,
      submitTime: submitTime ?? this.submitTime,
      serviceDate: serviceDate ?? this.serviceDate,
      serviceTime: serviceTime ?? this.serviceTime,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      isGuaranty: isGuaranty ?? this.isGuaranty,
      carName: carName ?? this.carName,
      carModelId: carModelId ?? this.carModelId,
      location: location ?? this.location,
      callLogId: callLogId ?? this.callLogId,
      channelType: channelType ?? this.channelType,
      cityId: cityId ?? this.cityId,
      vin: vin ?? this.vin,
      gender: gender ?? this.gender,
      kilometer: kilometer ?? this.kilometer,
      evaluationKilometer: evaluationKilometer ?? this.evaluationKilometer,
      customerDisability: customerDisability ?? this.customerDisability,
      trackCode: trackCode ?? this.trackCode,
      carColor: carColor ?? this.carColor,
      customerDisabilityTitle:
      customerDisabilityTitle ?? this.customerDisabilityTitle,
      customerMobileNumber:
      customerMobileNumber ?? this.customerMobileNumber,
      carEngineNumber: carEngineNumber ?? this.carEngineNumber,
      carColorTitle: carColorTitle ?? this.carColorTitle,
      foreigner: foreigner ?? this.foreigner,
      vip: vip ?? this.vip,
      hasEmdadgarInvoice: hasEmdadgarInvoice ?? this.hasEmdadgarInvoice,
    );
  }
  InvoiceType? getInvoiceType() {
    final bool hasInvoice = invoiceDocumentGuid != null;
    final bool isHomeService =
        type == RequestType.homeService.value;

    if (hasInvoice) {
      return InvoiceType.invoice;
    }

    return isHomeService ? InvoiceType.preInvoice : null;
  }

  String? get invoiceDocumentGuid {
    return actions
        ?.where((x) => x.code?.toLowerCase() == 'invoice')
        .map((x) => x.extra)
        .firstOrNull;
  }


  RequestModel toModel() {
    return RequestModel(
      id: id,
      requestNo: requestNo,
      requestDate: requestDate,
      status: status,
      statusTitle: statusTitle,
      type: type,
      chassisNo: chassisNo,
      licensePlate: licensePlate,
      distanceTraveledKm: distanceTraveledKm,
      lastName: lastName,
      khedmatResanFullName: khedmatResanFullName,
      khedmatResanCode: khedmatResanCode,
      typeTitle: typeTitle,
      actions: actions?.map((action) => action.toModel()).toList(),
      defectId: defectId,
      defectTitle: defectTitle,
      defectDescription: defectDescription,
      nationalCode: nationalCode,
      serviceTime: serviceTime,
      submitDate: submitDate,
      serviceDate: serviceDate,
      submitTime: submitTime,
      carName: carName,
      carModelId: carModelId,
      isGuaranty: isGuaranty,
      hasSubscription: hasSubscription,
      firstName: firstName,
      location: location,
      hasEmdadgarInvoice: hasEmdadgarInvoice,
    );
  }
}

class RequestHistoryActionsEntity {
  final String? name;
  final String? code;
  final String? extra;

  const RequestHistoryActionsEntity({
    this.name,
    this.code,
    this.extra,
  });

  RequestHistoryActionsModel toModel() {
    return RequestHistoryActionsModel(
      name: name,
      code: code,
      extra: extra,
    );
  }
}
