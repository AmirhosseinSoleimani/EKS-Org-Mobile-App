import 'package:eks_sana_plus_org/src/features/agency_info/data/models/vehicle_info_search_page_model.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/vehicle_info_search_entity.dart';

class VehicleInfoSearchPageEntity {
  const VehicleInfoSearchPageEntity({
    this.records,
    this.count,
  });

  final List<VehicleInfoSearchEntity>? records;
  final int? count;

  VehicleInfoSearchPageModel toModel() {
    return VehicleInfoSearchPageModel(
      records: records?.map((item) => item.toModel()).toList(),
      count: count,
    );
  }

  VehicleInfoSearchPageEntity copyWith({
    List<VehicleInfoSearchEntity>? records,
    int? count,
  }) {
    return VehicleInfoSearchPageEntity(
      records: records ?? this.records,
      count: count ?? this.count,
    );
  }
}
