import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/services_param_model.dart';

class ServicesParamEntity {
  final int serviceType;
  final int defectId;
  final String nationalCode;
  final int kilometer;
  final String carInfoGuid;
  final int carModelId;

  const ServicesParamEntity({
    required this.serviceType,
    required this.defectId,
    required this.nationalCode,
    required this.kilometer,
    required this.carInfoGuid,
    required this.carModelId,
  });

  ServicesParamEntity copyWith({
    int? serviceType,

    int? defectId,

    String? nationalCode,

    int? kilometer,

    String? carInfoGuid,

    int? carModelId,
  }) {
    return ServicesParamEntity(
      serviceType: serviceType ?? this.serviceType,

      defectId: defectId ?? this.defectId,

      nationalCode: nationalCode ?? this.nationalCode,

      kilometer: kilometer ?? this.kilometer,

      carInfoGuid: carInfoGuid ?? this.carInfoGuid,

      carModelId: carModelId ?? this.carModelId,
    );
  }

  ServicesParamModel toModel() => ServicesParamModel(
    serviceType: serviceType,
    defectId: defectId,
    nationalCode: nationalCode,
    kilometer: kilometer,
    carInfoGuid: carInfoGuid,
    carModelId: carModelId,
  );
}
