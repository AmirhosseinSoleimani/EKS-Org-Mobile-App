import 'vehicle_info_entity.dart';

class VehicleInfoPageEntity {
  const VehicleInfoPageEntity({
    required this.records,
    required this.count,
  });

  final List<VehicleInfoEntity> records;
  final int count;
}
