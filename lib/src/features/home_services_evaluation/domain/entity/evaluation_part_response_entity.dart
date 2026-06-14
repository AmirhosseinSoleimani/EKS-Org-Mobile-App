import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_part_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';

class EvaluationPartResponseEntity {
  int? partGroupId;
  String? partGroupName;
  int? serial;
  String? laborName;
  int? laborId;
  String? laborCode;
  String? partName;
  int? partPrice;
  int? count;
  String? mark;
  bool? isCausing;
  bool? isReusable;
  bool? hasReusable;
  int? reusablePrice;
  String? reusablePartSerial;
  String? reusablePartName;
  List<CostCenterEntity>? costCenterList;
  CostCenterEntity? costCenterObject;
  int? garantyDurationDayKilometer;
  int? garantyKilometerKilometer;

  EvaluationPartResponseEntity({
    this.partName,
    this.laborId,
    this.serial,
    this.mark,
    this.partGroupId,
    this.costCenterList,
    this.isReusable,
    this.costCenterObject,
    this.reusablePrice,
    this.hasReusable,
    this.isCausing,
    this.laborCode,
    this.partPrice,
    this.count,
    this.partGroupName,
    this.reusablePartName,
    this.reusablePartSerial,
    this.laborName,
    this.garantyDurationDayKilometer,
    this.garantyKilometerKilometer,
  });

  EvaluationPartResponseEntity copyWith({
    int? partGroupId,
    String? partGroupName,
    int? serial,
    int? laborId,
    String? laborCode,
    String? partName,
    int? partPrice,
    int? count,
    String? mark,
    bool? isCausing,
    bool? isReusable,
    bool? hasReusable,
    int? reusablePrice,
    String? reusablePartSerial,
    String? reusablePartName,
    List<CostCenterEntity>? costCenterList,
    CostCenterEntity? costCenterObject,
    String? laborName,
    int? garantyDurationDayKilometer,
    int? garantyKilometerKilometer,
  }) {
    return EvaluationPartResponseEntity(
      partGroupId: partGroupId ?? this.partGroupId,
      partGroupName: partGroupName ?? this.partGroupName,
      serial: serial ?? this.serial,
      laborId: laborId ?? this.laborId,
      laborCode: laborCode ?? this.laborCode,
      partName: partName ?? this.partName,
      partPrice: partPrice ?? this.partPrice,
      count: count ?? this.count,
      mark: mark ?? this.mark,
      isCausing: isCausing ?? this.isCausing,
      isReusable: isReusable ?? this.isReusable,
      hasReusable: hasReusable ?? this.hasReusable,
      reusablePrice: reusablePrice ?? this.reusablePrice,
      reusablePartSerial: reusablePartSerial ?? this.reusablePartSerial,
      reusablePartName: reusablePartName ?? this.reusablePartName,
      costCenterList: costCenterList ?? this.costCenterList,
      costCenterObject: costCenterObject ?? this.costCenterObject,
      laborName: laborName ?? this.laborName,
      garantyDurationDayKilometer:
          garantyDurationDayKilometer ?? this.garantyDurationDayKilometer,
      garantyKilometerKilometer:
          garantyKilometerKilometer ?? this.garantyKilometerKilometer,
    );
  }

  EvaluationPartResponseModel toModel() {
    return EvaluationPartResponseModel(
      partName: partName,
      serial: serial,
      isCausing: isCausing,
      laborId: laborId,
      mark: mark,
      partPrice: partPrice,
      isReusable: isReusable,
      count: count,
      reusablePrice: reusablePrice,
      partGroupName: partGroupName,
      reusablePartName: reusablePartName,
      reusablePartSerial: reusablePartSerial,
      partGroupId: partGroupId,
      hasReusable: hasReusable,
      laborCode: laborCode,
      costCenterList: costCenterList?.map((e) => e.toModel()).toList(),
      costCenterObject: costCenterObject?.toModel(),
      laborName: laborName,
      garantyKilometerKilometer: garantyKilometerKilometer,
      garantyDurationDayKilometer: garantyDurationDayKilometer,
    );
  }
}
