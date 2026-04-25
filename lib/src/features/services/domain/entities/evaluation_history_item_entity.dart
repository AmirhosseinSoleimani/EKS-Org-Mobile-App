import 'package:eks_sana_plus_org/src/features/services/data/models/evaluation_history_item_model.dart';

class EvaluationHistoryItemEntity {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? insertUserName;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final String? defectInfoTitle;
  final String? emdadServiceCategoryTitle;
  final double? distanceToCustomer;
  final double? distanceHamlCustomer;
  final bool? isAccepted;
  final int? stopTime;
  final bool? useDakal;
  final bool? payAvarezi;
  final String? emdadgarNavganTypeTitle;
  final String? arriveDateTime;
  final String? arriveDateTimeJalali;
  final String? endWorkDateTime;
  final String? endWorkDateTimeJalali;
  final String? assignTrackerName;
  final String? arriveTrackerName;
  final String? endWorkTrackerName;
  final int? invoiceId;
  final String? statusTitle;
  final String? description;
  final String? cancelReasonTitle;
  final String? cancelReasonDetailTitle;
  final bool? hasImage;

  const EvaluationHistoryItemEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.insertUserName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.defectInfoTitle,
    this.emdadServiceCategoryTitle,
    this.distanceToCustomer,
    this.distanceHamlCustomer,
    this.isAccepted,
    this.stopTime,
    this.useDakal,
    this.payAvarezi,
    this.emdadgarNavganTypeTitle,
    this.arriveDateTime,
    this.arriveDateTimeJalali,
    this.endWorkDateTime,
    this.endWorkDateTimeJalali,
    this.assignTrackerName,
    this.arriveTrackerName,
    this.endWorkTrackerName,
    this.invoiceId,
    this.statusTitle,
    this.hasImage,
    this.description,
    this.cancelReasonTitle,
    this.cancelReasonDetailTitle,
  });

  EvaluationHistoryItemEntity copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? insertUserName,
    String? insertDateTime,
    String? insertDateTimeJalali,
    String? defectInfoTitle,
    String? emdadServiceCategoryTitle,
    double? distanceToCustomer,
    double? distanceHamlCustomer,
    bool? isAccepted,
    int? stopTime,
    bool? useDakal,
    bool? payAvarezi,
    String? emdadgarNavganTypeTitle,
    String? arriveDateTime,
    String? arriveDateTimeJalali,
    String? endWorkDateTime,
    String? endWorkDateTimeJalali,
    String? assignTrackerName,
    String? arriveTrackerName,
    String? endWorkTrackerName,
    int? invoiceId,
    String? statusTitle,
    String? description,
     String? cancelReasonTitle,
     String? cancelReasonDetailTitle,
    bool? hasImage,
  }) {
    return EvaluationHistoryItemEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      insertUserName: insertUserName ?? this.insertUserName,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
      defectInfoTitle: defectInfoTitle ?? this.defectInfoTitle,
      emdadServiceCategoryTitle:
          emdadServiceCategoryTitle ?? this.emdadServiceCategoryTitle,
      distanceToCustomer: distanceToCustomer ?? this.distanceToCustomer,
      distanceHamlCustomer: distanceHamlCustomer ?? this.distanceHamlCustomer,
      isAccepted: isAccepted ?? this.isAccepted,
      stopTime: stopTime ?? this.stopTime,
      useDakal: useDakal ?? this.useDakal,
      payAvarezi: payAvarezi ?? this.payAvarezi,
      emdadgarNavganTypeTitle:
          emdadgarNavganTypeTitle ?? this.emdadgarNavganTypeTitle,
      arriveDateTime: arriveDateTime ?? this.arriveDateTime,
      arriveDateTimeJalali: arriveDateTimeJalali ?? this.arriveDateTimeJalali,
      endWorkDateTime: endWorkDateTime ?? this.endWorkDateTime,
      endWorkDateTimeJalali:
          endWorkDateTimeJalali ?? this.endWorkDateTimeJalali,
      assignTrackerName: assignTrackerName ?? this.assignTrackerName,
      arriveTrackerName: arriveTrackerName ?? this.arriveTrackerName,
      endWorkTrackerName: endWorkTrackerName ?? this.endWorkTrackerName,
      invoiceId: invoiceId ?? this.invoiceId,
      statusTitle: statusTitle ?? this.statusTitle,
      hasImage: hasImage ?? this.hasImage,
      description: description ?? this.description,
      cancelReasonTitle: cancelReasonTitle ?? this.cancelReasonTitle,
      cancelReasonDetailTitle: cancelReasonDetailTitle ?? this.cancelReasonDetailTitle,
    );
  }

  EvaluationHistoryItemModel toModel() {
    return EvaluationHistoryItemModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      insertUserName: insertUserName,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      defectInfoTitle: defectInfoTitle,
      emdadServiceCategoryTitle: emdadServiceCategoryTitle,
      distanceToCustomer: distanceToCustomer,
      distanceHamlCustomer: distanceHamlCustomer,
      isAccepted: isAccepted,
      stopTime: stopTime,
      useDakal: useDakal,
      payAvarezi: payAvarezi,
      emdadgarNavganTypeTitle: emdadgarNavganTypeTitle,
      arriveDateTime: arriveDateTime,
      arriveDateTimeJalali: arriveDateTimeJalali,
      endWorkDateTime: endWorkDateTime,
      endWorkDateTimeJalali: endWorkDateTimeJalali,
      assignTrackerName: assignTrackerName,
      arriveTrackerName: arriveTrackerName,
      endWorkTrackerName: endWorkTrackerName,
      invoiceId: invoiceId,
      statusTitle: statusTitle,
      hasImage: hasImage,
      description: description,
      cancelReasonTitle: cancelReasonTitle,
      cancelReasonDetailTitle: cancelReasonDetailTitle,
    );
  }
}
