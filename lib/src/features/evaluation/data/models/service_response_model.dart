import 'package:eks_sana_plus_org/src/features/evaluation/data/models/defect_info_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/emdad_service_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/defect_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdad_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_response_entity.dart';

class ServiceResponseModel extends ServiceResponseEntity {
  const ServiceResponseModel({
    required super.id,
    required super.carModelId,
    required super.guid,
    required super.name,
    required super.chassisNo,

    required List<EmdadServiceEntity> super.emdadServices,

    required DefectInfoEntity super.defectInfo,
  });

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceResponseModel(
      id: _toInt(json['id']),

      carModelId: _toInt(json['carModelId']),

      guid: json['guid']?.toString() ?? '',

      name: json['name']?.toString() ?? '',

      chassisNo: json['chassisNo']?.toString() ?? '',

      emdadServices: (json['emdadServices'] as List<dynamic>? ?? [])
          .map((e) => EmdadServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),

      defectInfo: DefectInfoModel.fromJson(
        (json['defectInfo'] as Map<String, dynamic>? ?? {}),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'carModelId': carModelId,

      'guid': guid,

      'name': name,

      'chassisNo': chassisNo,

      'emdadServices': emdadServices
          .map((e) => (e as EmdadServiceModel).toJson())
          .toList(),

      'defectInfo': (defectInfo as DefectInfoModel).toJson(),
    };
  }

  static int _toInt(dynamic v) {
    if (v is int) return v;

    if (v is String) return int.tryParse(v) ?? 0;

    if (v is num) return v.toInt();

    return 0;
  }
}
