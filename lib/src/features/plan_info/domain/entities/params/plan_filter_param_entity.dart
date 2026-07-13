import '../../../data/models/params/plan_filter_param_model.dart';

class PlanFilterParamEntity {
  final int skip;
  final int pageSize;
  final String? title;
  final bool? isActive;
  final String? emdadUnitName;
  final String? shiftTitle;
  final String? specialPlanTitle;
  final int? seatType;
  final String? locationTitle;
  final String? fromDate;
  final String? toDate;

  const PlanFilterParamEntity({
    this.skip = 0,
    this.pageSize = 20,
    this.title,
    this.isActive,
    this.emdadUnitName,
    this.shiftTitle,
    this.specialPlanTitle,
    this.seatType,
    this.locationTitle,
    this.fromDate,
    this.toDate,
  });

  PlanFilterParamModel toModel() {
    return PlanFilterParamModel(
      skip: skip,
      pageSize: pageSize,
      title: title,
      isActive: isActive,
      emdadUnitName: emdadUnitName,
      shiftTitle: shiftTitle,
      specialPlanTitle: specialPlanTitle,
      seatType: seatType,
      locationTitle: locationTitle,
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}
