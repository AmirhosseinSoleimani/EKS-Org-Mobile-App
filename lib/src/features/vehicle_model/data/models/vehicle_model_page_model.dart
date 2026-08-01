import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/data/models/vehicle_model_model.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_page_entity.dart';

class VehicleModelPageModel extends VehicleModelPageEntity {
  const VehicleModelPageModel({
    super.records,
    super.count,
  });

  factory VehicleModelPageModel.fromJson(Map<String, dynamic> json) {
    final records = VehicleModelJsonHelper.pageRecords(json)
        .map(VehicleModelModel.fromJson)
        .where((item) => item.id != null)
        .toList();

    return VehicleModelPageModel(
      records: records,
      count: VehicleModelJsonHelper.pageCount(json),
    );
  }
}
