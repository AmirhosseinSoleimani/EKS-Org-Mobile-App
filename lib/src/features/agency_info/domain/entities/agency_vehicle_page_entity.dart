import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_vehicle_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_vehicle_entity.dart';

class AgencyVehiclePageEntity {
  const AgencyVehiclePageEntity({
    this.records,
    this.count,
  });

  final List<AgencyVehicleEntity>? records;
  final int? count;

  AgencyVehiclePageModel toModel() {
    return AgencyVehiclePageModel(
      records: records?.map((item) => item.toModel()).toList(),
      count: count,
    );
  }

  AgencyVehiclePageEntity copyWith({
    List<AgencyVehicleEntity>? records,
    int? count,
  }) {
    return AgencyVehiclePageEntity(
      records: records ?? this.records,
      count: count ?? this.count,
    );
  }
}
