import 'package:eks_sana_plus_org/src/shared/features/map/data/models/param/area_base_info_param_model.dart';

class AreaBaseInfoParamEntity {
  double? latitude;
  double? longitude;
  List<int>? areaBusinessUsageTypes;

  AreaBaseInfoParamEntity({
    this.latitude,
    this.longitude,
    this.areaBusinessUsageTypes,
  });

  AreaBaseInfoParamEntity copyWith({
    double? latitude,
    double? longitude,
    List<int>? areaBusinessUsageTypes,
  }) {
    return AreaBaseInfoParamEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      areaBusinessUsageTypes:
          areaBusinessUsageTypes ?? this.areaBusinessUsageTypes,
    );
  }

  AreaBaseInfoParamModel toModel() {
    return AreaBaseInfoParamModel(
      latitude: latitude,
      longitude: longitude,
      areaBusinessUsageTypes: areaBusinessUsageTypes,
    );
  }
}
