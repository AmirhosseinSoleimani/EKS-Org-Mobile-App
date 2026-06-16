import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_labor_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_part_entity.dart';

class InsertHomeServiceLaborEntity {
  const InsertHomeServiceLaborEntity({
    this.serviceId,
    this.laborCode,
    this.laborPrice,
    this.costCenter,
    this.laborId,
    this.laborGroupId,
    this.laborDesc,
    this.parts,
    this.isMandatory,
    this.isImageMandatory,
  });

  final int? laborId;
  final int? laborGroupId;
  final String? laborDesc;
  final String? laborCode;
  final int? laborPrice;
  final int? serviceId;
  final InsertHomeServiceCostCenterEntity? costCenter;
  final List<InsertHomeServicePartEntity>? parts;
  final bool? isMandatory;
  final bool? isImageMandatory;

  InsertHomeServiceLaborEntity copyWith({
    int? laborId,
    int? laborGroupId,
    String? laborDesc,
    String? laborCode,
    int? laborPrice,
    int? serviceId,
    InsertHomeServiceCostCenterEntity? costCenter,
    List<InsertHomeServicePartEntity>? parts,
    bool? isMandatory,
    bool? isImageMandatory,
  }) {
    return InsertHomeServiceLaborEntity(
      laborId: laborId ?? this.laborId,
      laborGroupId: laborGroupId ?? this.laborGroupId,
      laborDesc: laborDesc ?? this.laborDesc,
      laborCode: laborCode ?? this.laborCode,
      laborPrice: laborPrice ?? this.laborPrice,
      serviceId: serviceId ?? this.serviceId,
      costCenter: costCenter ?? this.costCenter,
      parts: parts ?? this.parts,
      isMandatory: isMandatory ?? this.isMandatory,
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
    );
  }

  InsertHomeServiceLaborModel toModel() {
    return InsertHomeServiceLaborModel(
      laborId: laborId,
      laborGroupId: laborGroupId,
      laborDesc: laborDesc,
      costCenter: costCenter,
      laborCode: laborCode,
      serviceId: serviceId,
      laborPrice: laborPrice,
      isMandatory: isMandatory,
      isImageMandatory: isImageMandatory,
      parts: parts?.map((part) => part.toModel()).toList(),
    );
  }
}
