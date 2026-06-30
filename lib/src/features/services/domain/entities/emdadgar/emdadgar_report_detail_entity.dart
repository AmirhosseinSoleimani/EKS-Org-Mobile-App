import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/emdadgar_report_detail_model.dart';

class EmdadgarReportDetailEntity {
  int? success;
  String? successSubscribedCountText;
  String? successUnSubscribedCountText;

  int? cancel;
  String? cancelSubscribedCountText;
  String? cancelUnSubscribedCountText;

  int? successCount;
  int? successDoneAndClosedCount;
  int? successEligibleCanceled;

  int? successSubscribedCount;
  int? successUnSubscribedCount;

  int? cancelCount;
  int? cancelSubscribedCount;
  int? cancelUnSubscribedCount;

  int? lackOfCooperationCount;
  double? lackOfCooperationWeightSum;

  int? lackOfCooperationSubscribedCount;
  int? lackOfCooperationUnSubscribedCount;

  EmdadgarReportDetailEntity({
    this.success,
    this.successSubscribedCountText,
    this.successUnSubscribedCountText,
    this.cancel,
    this.cancelSubscribedCountText,
    this.cancelUnSubscribedCountText,
    this.successCount,
    this.successDoneAndClosedCount,
    this.successEligibleCanceled,
    this.successSubscribedCount,
    this.successUnSubscribedCount,
    this.cancelCount,
    this.cancelSubscribedCount,
    this.cancelUnSubscribedCount,
    this.lackOfCooperationCount,
    this.lackOfCooperationWeightSum,
    this.lackOfCooperationSubscribedCount,
    this.lackOfCooperationUnSubscribedCount,
  });

  EmdadgarReportDetailEntity copyWith({
    int? success,
    String? successSubscribedCountText,
    String? successUnSubscribedCountText,
    int? cancel,
    String? cancelSubscribedCountText,
    String? cancelUnSubscribedCountText,
    int? successCount,
    int? successDoneAndClosedCount,
    int? successEligibleCanceled,
    int? successSubscribedCount,
    int? successUnSubscribedCount,
    int? cancelCount,
    int? cancelSubscribedCount,
    int? cancelUnSubscribedCount,
    int? lackOfCooperationCount,
    double? lackOfCooperationWeightSum,
    int? lackOfCooperationSubscribedCount,
    int? lackOfCooperationUnSubscribedCount,
  }) {
    return EmdadgarReportDetailEntity(
      success: success ?? this.success,
      successSubscribedCountText:
          successSubscribedCountText ?? this.successSubscribedCountText,
      successUnSubscribedCountText:
          successUnSubscribedCountText ?? this.successUnSubscribedCountText,
      cancel: cancel ?? this.cancel,
      cancelSubscribedCountText:
          cancelSubscribedCountText ?? this.cancelSubscribedCountText,
      cancelUnSubscribedCountText:
          cancelUnSubscribedCountText ?? this.cancelUnSubscribedCountText,
      successCount: successCount ?? this.successCount,
      successDoneAndClosedCount:
          successDoneAndClosedCount ?? this.successDoneAndClosedCount,
      successEligibleCanceled:
          successEligibleCanceled ?? this.successEligibleCanceled,
      successSubscribedCount:
          successSubscribedCount ?? this.successSubscribedCount,
      successUnSubscribedCount:
          successUnSubscribedCount ?? this.successUnSubscribedCount,
      cancelCount: cancelCount ?? this.cancelCount,
      cancelSubscribedCount:
          cancelSubscribedCount ?? this.cancelSubscribedCount,
      cancelUnSubscribedCount:
          cancelUnSubscribedCount ?? this.cancelUnSubscribedCount,
      lackOfCooperationCount:
          lackOfCooperationCount ?? this.lackOfCooperationCount,
      lackOfCooperationWeightSum:
          lackOfCooperationWeightSum ?? this.lackOfCooperationWeightSum,
      lackOfCooperationSubscribedCount:
          lackOfCooperationSubscribedCount ??
          this.lackOfCooperationSubscribedCount,
      lackOfCooperationUnSubscribedCount:
          lackOfCooperationUnSubscribedCount ??
          this.lackOfCooperationUnSubscribedCount,
    );
  }

  EmdadgarReportDetailModel toModel() {
    return EmdadgarReportDetailModel(
      success: success,
      successSubscribedCountText: successSubscribedCountText,
      successUnSubscribedCountText: successUnSubscribedCountText,
      cancel: cancel,
      cancelSubscribedCountText: cancelSubscribedCountText,
      cancelUnSubscribedCountText: cancelUnSubscribedCountText,
      successCount: successCount,
      successDoneAndClosedCount: successDoneAndClosedCount,
      successEligibleCanceled: successEligibleCanceled,
      successSubscribedCount: successSubscribedCount,
      successUnSubscribedCount: successUnSubscribedCount,
      cancelCount: cancelCount,
      cancelSubscribedCount: cancelSubscribedCount,
      cancelUnSubscribedCount: cancelUnSubscribedCount,
      lackOfCooperationCount: lackOfCooperationCount,
      lackOfCooperationWeightSum: lackOfCooperationWeightSum,
      lackOfCooperationSubscribedCount: lackOfCooperationSubscribedCount,
      lackOfCooperationUnSubscribedCount: lackOfCooperationUnSubscribedCount,
    );
  }
}
