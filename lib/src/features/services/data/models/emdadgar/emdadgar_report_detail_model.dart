class EmdadgarReportDetailEntity {
  int? success;
  int? cancel;
  int? successCount;
  int? cancelCount;
  int? lackOfCooperationCount;
  double? lackOfCooperationWeightSum;

  EmdadgarReportDetailEntity({
    this.success,
    this.cancel,
    this.successCount,
    this.cancelCount,
    this.lackOfCooperationCount,
    this.lackOfCooperationWeightSum,
  });

  EmdadgarReportDetailModel toModel() {
    return EmdadgarReportDetailModel(
      success: success,
      cancel: cancel,
      successCount: successCount,
      cancelCount: cancelCount,
      lackOfCooperationCount: lackOfCooperationCount,
      lackOfCooperationWeightSum: lackOfCooperationWeightSum,
    );
  }
}

class EmdadgarReportDetailModel extends EmdadgarReportDetailEntity {
  EmdadgarReportDetailModel({
    super.success,
    super.cancel,
    super.successCount,
    super.cancelCount,
    super.lackOfCooperationCount,
    super.lackOfCooperationWeightSum,
  });

  factory EmdadgarReportDetailModel.fromJson(Map<String, dynamic> json) {
    return EmdadgarReportDetailModel(
      success: json["success"],
      cancel: json["cancel"],
      successCount: json["successCount"],
      cancelCount: json["cancelCount"],
      lackOfCooperationCount: json["lackOfCooperationCount"],
      lackOfCooperationWeightSum:
      json["lackOfCooperationWeightSum"]?.toDouble(),
    );
  }
}
