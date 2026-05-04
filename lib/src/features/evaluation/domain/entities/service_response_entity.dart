import 'package:eks_sana_plus_org/src/features/evaluation/data/models/service_response_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdad_service_entity.dart';

class ServiceResponseEntity {
  final int id;
  final int carModelId;
  final String guid;
  final String name;
  final String chassisNo;
  final List<EmdadServiceEntity> emdadServices;
  final DefectInfoEntity defectInfo;

  const ServiceResponseEntity({
    required this.id,
    required this.carModelId,
    required this.guid,
    required this.name,
    required this.chassisNo,
    required this.emdadServices,
    required this.defectInfo,
  });

  ServiceResponseEntity copyWith({
    int? id,
    int? carModelId,
    String? guid,
    String? name,
    String? chassisNo,
    List<EmdadServiceEntity>? emdadServices,
    DefectInfoEntity? defectInfo,
  }) {
    return ServiceResponseEntity(
      id: id ?? this.id,
      carModelId: carModelId ?? this.carModelId,
      guid: guid ?? this.guid,
      name: name ?? this.name,
      chassisNo: chassisNo ?? this.chassisNo,
      emdadServices: emdadServices ?? this.emdadServices,
      defectInfo: defectInfo ?? this.defectInfo,
    );
  }

  ServiceResponseModel toModel() => ServiceResponseModel(
    id: id,
    carModelId: carModelId,
    guid: guid,
    name: name,
    chassisNo: chassisNo,
    emdadServices: emdadServices.map((e) => e.toModel()).toList(),
    defectInfo: defectInfo.toModel(),
  );
}
