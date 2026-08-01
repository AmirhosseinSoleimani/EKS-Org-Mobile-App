import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';

class VehicleModelPageEntity {
  const VehicleModelPageEntity({
    this.records = const [],
    this.count = 0,
  });

  final List<VehicleModelEntity> records;
  final int count;
}
