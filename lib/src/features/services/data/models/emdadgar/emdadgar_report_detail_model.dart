
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_report_detail_entity.dart';

class EmdadgarReportDetailModel extends EmdadgarReportDetailEntity {
  EmdadgarReportDetailModel({
    super.success,
    super.successSubscribedCountText,
    super.successUnSubscribedCountText,
    super.cancel,
    super.cancelSubscribedCountText,
    super.cancelUnSubscribedCountText,
    super.successCount,
    super.successDoneAndClosedCount,
    super.successEligibleCanceled,
    super.successSubscribedCount,
    super.successUnSubscribedCount,
    super.cancelCount,
    super.cancelSubscribedCount,
    super.cancelUnSubscribedCount,
    super.lackOfCooperationCount,
    super.lackOfCooperationWeightSum,
    super.lackOfCooperationSubscribedCount,
    super.lackOfCooperationUnSubscribedCount,
  });

  factory EmdadgarReportDetailModel.fromJson(
      Map<String, dynamic> json) {
    return EmdadgarReportDetailModel(
      success: json["success"],
      successSubscribedCountText:
      json["successSubscribedCountText"],
      successUnSubscribedCountText:
      json["successUnSubscribedCountText"],
      cancel: json["cancel"],
      cancelSubscribedCountText:
      json["cancelSubscribedCountText"],
      cancelUnSubscribedCountText:
      json["cancelUnSubscribedCountText"],
      successCount: json["successCount"],
      successDoneAndClosedCount:
      json["successDoneAndClosedCount"],
      successEligibleCanceled:
      json["successEligibleCanceled"],
      successSubscribedCount:
      json["successSubscribedCount"],
      successUnSubscribedCount:
      json["successUnSubscribedCount"],
      cancelCount: json["cancelCount"],
      cancelSubscribedCount:
      json["cancelSubscribedCount"],
      cancelUnSubscribedCount:
      json["cancelUnSubscribedCount"],
      lackOfCooperationCount:
      json["lackOfCooperationCount"],
      lackOfCooperationWeightSum:
      (json["lackOfCooperationWeightSum"] as num?)
          ?.toDouble(),
      lackOfCooperationSubscribedCount:
      json["lackOfCooperationSubscribedCount"],
      lackOfCooperationUnSubscribedCount:
      json["lackOfCooperationUnSubscribedCount"],
    );
  }
}