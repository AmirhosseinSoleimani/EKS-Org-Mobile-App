import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_labor_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';

class EvaluationLaborResponseEntity {
  EvaluationLaborResponseEntity({
    this.laborId,
    this.laborName,
    this.laborGroupId,
    this.laborCode,
    this.laborPrice,
    this.standardTime,
    this.parts,
    this.overlapCodes,
    this.costCenterList,
    this.costCenterObject,
    this.isCausing,
    this.laborGroupDesc,
    this.isChangedByPart,
    this.needImage,
    this.isImageMandatory,
  });

  int? laborGroupId;
  String? laborGroupDesc;
  int? laborId;
  String? laborCode;
  String? laborName;
  double? standardTime;
  int? laborPrice;
  String? overlapCodes;
  bool? isCausing;
  bool? isChangedByPart;
  List<EvaluationPartResponseEntity>? parts;
  List<CostCenterEntity>? costCenterList;
  CostCenterEntity? costCenterObject;
  bool? needImage;
  bool? isImageMandatory;

  EvaluationLaborResponseEntity copyWith({
    int? laborGroupId,
    String? laborGroupDesc,
    int? laborId,
    String? laborCode,
    String? laborName,
    double? standardTime,
    int? laborPrice,
    String? overlapCodes,
    bool? isCausing,
    List<EvaluationPartResponseEntity>? parts,
    List<CostCenterEntity>? costCenterList,
    CostCenterEntity? costCenterObject,
    bool? needImage,
    bool? isImageMandatory,
  }) {
    return EvaluationLaborResponseEntity(
      laborGroupId: laborGroupId ?? this.laborGroupId,
      laborGroupDesc: laborGroupDesc ?? this.laborGroupDesc,
      laborId: laborId ?? this.laborId,
      laborCode: laborCode ?? this.laborCode,
      laborName: laborName ?? this.laborName,
      standardTime: standardTime ?? this.standardTime,
      laborPrice: laborPrice ?? this.laborPrice,
      overlapCodes: overlapCodes ?? this.overlapCodes,
      isCausing: isCausing ?? this.isCausing,
      parts: parts ?? this.parts,
      costCenterList: costCenterList ?? this.costCenterList,
      costCenterObject: costCenterObject ?? this.costCenterObject,
      needImage: needImage ?? this.needImage,
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
    );
  }

  EvaluationLaborResponseModel toModel() {
    return EvaluationLaborResponseModel(
      laborGroupId: laborGroupId,
      standardTime: standardTime,
      laborId: laborId,
      laborName: laborName,
      laborCode: laborCode,
      costCenterList: costCenterList?.map((e) => e.toModel()).toList(),
      overlapCodes: overlapCodes,
      laborPrice: laborPrice,
      parts: parts?.map((part) => part.toModel()).toList(),
      costCenterObject: costCenterObject?.toModel(),
      isCausing: isCausing,
      laborGroupDesc: laborGroupDesc,
      needImage: needImage,
      isImageMandatory: isImageMandatory,
    );
  }
}
